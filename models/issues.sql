-- issues.sql

-- Define the dbt model
{{ config(materialized='table') }}

SELECT
    (_AIRBYTE_DATA->>'created')::TIMESTAMP WITH TIME ZONE AS created_at,
    (_AIRBYTE_DATA->>'updated')::TIMESTAMP WITH TIME ZONE AS updated_at,
    (_AIRBYTE_DATA->>'id')::int as id,
    (_AIRBYTE_DATA->>'key')::varchar as name,
    (_AIRBYTE_DATA->>'self')::text as url,
    (_AIRBYTE_DATA->'fields'->'summary')::text as summary,
    (_AIRBYTE_DATA->'fields'->'status'->'name')::varchar as status,
    (_AIRBYTE_DATA->'fields'->'reporter'->'emailAddress')::varchar as reporter,
    (_AIRBYTE_DATA->'fields'->'project'->'name')::varchar as project_name,
    (_AIRBYTE_DATA->'fields'->'project'->'id')::varchar as project_id,
    (_AIRBYTE_DATA->'fields'->'priority'->'name')::varchar as priority,
    (_AIRBYTE_DATA->'fields'->'labels')::text as labels,
    (_AIRBYTE_DATA->'fields'->'issuetype'->'name')::varchar as issue_type,
    (_AIRBYTE_DATA->'fields'->'creator'->'emailAddress')::varchar as creator,
    (_AIRBYTE_DATA->'fields'->'assignee'->'emailAddress')::varchar as assignee

    FROM
  airbyte.airbyte._airbyte_raw_issues
