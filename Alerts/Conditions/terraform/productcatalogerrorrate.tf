resource "newrelic_nrql_alert_condition" "otel_productcataog_error_rate" {
  account_id = 4361744
  policy_id = <Your Policy ID>
  type = "static"
  name = "OTEL ProductCataog Error Rate"
  enabled = true
  violation_time_limit_seconds = 259200

  nrql {
    query = "SELECT (filter(count(*), WHERE otel.status_code = 'ERROR') * 100) / count(*) as 'Error Rate' FROM Span WHERE entity.guid IN ('NDM2MTc0NHxFWFR8U0VSVklDRXwyNzkzNjg5Mjc1NTA3NTA0MDM') AND span.kind LIKE 'server' OR span.kind LIKE 'consumer' OR kind LIKE 'server' OR kind LIKE 'consumer' FACET entity.name"
  }

  critical {
    operator = "above"
    threshold = 1
    threshold_duration = 300
    threshold_occurrences = "all"
  }
  fill_option = "none"
  aggregation_window = 60
  aggregation_method = "event_flow"
  aggregation_delay = 120
}
