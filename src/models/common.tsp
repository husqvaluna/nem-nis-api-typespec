import "../types/core.tsp";

model ModelError {
  @example("FAILURE")
  code: string;
  @example("Account does not exist")
  message: string;
}
