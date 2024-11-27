# Big Countries Query

## Table: World

| Column Name | Type    |
|-------------|---------|
| name        | varchar |
| continent   | varchar |
| area        | int     |
| population  | int     |
| gdp         | bigint  |

- `name` is the primary key (column with unique values) for this table.
- Each row of this table gives information about:
  - the name of a country,
  - the continent to which it belongs,
  - its area, population, and GDP value.

## Definition of a "Big Country"

A country is considered **big** if:
1. It has an area of at least 3,000,000 (i.e., 3000000 km²), or
2. It has a population of at least 25,000,000 (i.e., 25000000).

## Problem Statement

Write a query to find the `name`, `population`, and `area` of the big countries.

### Example Input

**World table:**

| name        | continent | area    | population | gdp          |
|-------------|-----------|---------|------------|--------------|
| Afghanistan | Asia      | 652230  | 25500100   | 20343000000  |
| Albania     | Europe    | 28748   | 2831741    | 12960000000  |
| Algeria     | Africa    | 2381741 | 37100000   | 188681000000 |
| Andorra     | Europe    | 468     | 78115      | 3712000000   |
| Angola      | Africa    | 1246700 | 20609294   | 100990000000 |

### Example Output

| name        | population | area    |
|-------------|------------|---------|
| Afghanistan | 25500100   | 652230  |
| Algeria     | 37100000   | 2381741 |

