# Key Queries

Here are the most useful analytical queries for exploring the Airbnb dataset, organized by business question. All queries use the `project` schema.

***

## 1. Average Price and Service Fee by Country

**Goal**  
Compare average listing price and service fee across countries.

**SQL**
```sql
SELECT
  c.country_name,
  COUNT(*) AS listings,
  AVG(l.price) AS avg_price,
  AVG(l.service_fee) AS avg_service_fee
FROM project.listings l
JOIN project.countries c
  ON c.country_code = l.country_code
WHERE l.price IS NOT NULL
GROUP BY c.country_name
ORDER BY avg_price DESC;
```

***

## 2. Neighbourhood Groups by Listings Count

**Goal**  
Identify which neighbourhood groups have the most listings.

**SQL**
```sql
SELECT
  ng.group_name,
  COUNT(*) AS listings
FROM project.listings l
JOIN project.neighbourhoods n
  ON n.neighbourhood_id = l.neighbourhood_id
JOIN project.neighbourhood_groups ng
  ON ng.neighbourhood_group_id = n.neighbourhood_group_id
GROUP BY ng.group_name
ORDER BY listings DESC;
```

***

## 3. Top 10 Neighbourhoods by Total Reviews

**Goal**  
Find the most reviewed neighbourhoods (top 10).

**SQL**
```sql
SELECT
  ng.group_name,
  n.neighbourhood_name,
  SUM(COALESCE(rs.number_of_reviews, 0)) AS total_reviews,
  COUNT(*) AS listings
FROM project.listings l
JOIN project.neighbourhoods n
  ON n.neighbourhood_id = l.neighbourhood_id
JOIN project.neighbourhood_groups ng
  ON ng.neighbourhood_group_id = n.neighbourhood_group_id
LEFT JOIN project.listing_review_summary rs
  ON rs.listing_id = l.listing_id
GROUP BY ng.group_name, n.neighbourhood_name
ORDER BY total_reviews DESC
LIMIT 10;
```

***

## 4. Most Expensive Room Types per Country

**Goal**  
Show the highest average price room type for each country.

**SQL**
```sql
SELECT
  c.country_name,
  rt.room_type_name,
  COUNT(*) AS listings,
  AVG(l.price) AS avg_price
FROM project.listings l
JOIN project.countries c
  ON c.country_code = l.country_code
JOIN project.room_types rt
  ON rt.room_type_id = l.room_type_id
WHERE l.price IS NOT NULL
GROUP BY c.country_name, rt.room_type_name
ORDER BY c.country_name, avg_price DESC;
```

***

## 5. Instant Bookable Share by Neighbourhood Group

**Goal**  
Measure instant bookable listing percentage by neighbourhood group.

**SQL**
```sql
SELECT
  ng.group_name,
  COUNT(*) AS listings,
  AVG(CASE WHEN l.instant_bookable THEN 1.0 ELSE 0.0 END) AS share_instant_bookable
FROM project.listings l
JOIN project.neighbourhoods n
  ON n.neighbourhood_id = l.neighbourhood_id
JOIN project.neighbourhood_groups ng
  ON ng.neighbourhood_group_id = n.neighbourhood_group_id
GROUP BY ng.group_name
ORDER BY share_instant_bookable DESC;
```

***

## 6. Host Listing Count Mismatches

**Goal**  
Find hosts where `calculated_listings_count` doesn't match actual listings (top 20 discrepancies).

**SQL**
```sql
SELECT
  h.host_id,
  h.host_name,
  h.calculated_listings_count,
  COUNT(l.listing_id) AS actual_listings_count,
  (COUNT(l.listing_id) - COALESCE(h.calculated_listings_count, 0)) AS diff
FROM project.hosts h
LEFT JOIN project.listings l
  ON l.host_id = h.host_id
GROUP BY h.host_id, h.host_name, h.calculated_listings_count
ORDER BY ABS(COUNT(l.listing_id) - COALESCE(h.calculated_listings_count, 0)) DESC
LIMIT 20;
```

***

## 7. Suspicious Pricing Detection

**Goal**  
Identify listings with invalid pricing (price ≤ 0 or service_fee > price).

**SQL**
```sql
SELECT
  COUNT(*) AS total_listings,
  SUM(CASE WHEN l.price <= 0 THEN 1 ELSE 0 END) AS price_non_positive,
  SUM(CASE WHEN l.price IS NOT NULL AND l.service_fee IS NOT NULL AND l.service_fee > l.price THEN 1 ELSE 0 END) AS fee_greater_than_price,
  100.0 * SUM(
    CASE
      WHEN l.price <= 0
        OR (l.price IS NOT NULL AND l.service_fee IS NOT NULL AND l.service_fee > l.price)
      THEN 1 ELSE 0
    END
  ) / NULLIF(COUNT(*), 0) AS pct_suspicious
FROM project.listings l;
```

***

## 8. Review Activity Over Time

**Goal**  
Track listings with reviews by month (temporal analysis).

**SQL**
```sql
SELECT
  DATE_TRUNC('month', rs.last_review)::date AS review_month,
  COUNT(*) AS listings_with_reviews
FROM project.listing_review_summary rs
WHERE rs.last_review IS NOT NULL
GROUP BY DATE_TRUNC('month', rs.last_review)::date
ORDER BY review_month;
```

***

## 9. Listings Within Radius (Spatial Query)

**Goal**  
Count listings within 5km of a specific point (example: Times Square, NYC: -73.9855, 40.7580).

**SQL**
```sql
SELECT
  COUNT(*) AS listings_within_5km
FROM project.listings l
WHERE l.geom IS NOT NULL
  AND ST_DWithin(
    l.geom::geography,
    ST_SetSRID(ST_MakePoint(-73.9855, 40.7580), 4326)::geography,
    5000  -- 5km in meters
  );
```
