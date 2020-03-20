/// Enumeration to describe the actual STATE of the order
/// UNKNOWN: Status is UNKNOWN
/// PROCESSING: Order shows up in the FilmLab Backend
/// Done: Order is processed and will be shipped
enum FilmDevelopmentStatusSummary {
  UNKNOWN,
  PROCESSING,
  DONE
}