resource "newrelic_nrql_alert_condition" "otel_checkout_errors_traces" {
  account_id = 4361744
  policy_id = 5366449
  type = "static"
  name = "OTEL CheckOut Errors Traces"
  enabled = true
  violation_time_limit_seconds = 259200

  nrql {
    query = "SELECT count(*) from Span where entity.name like 'frontendproxy' and error =true and http.url LIKE '%checkout%'"
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
