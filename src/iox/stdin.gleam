import gleam/dynamic
import gleam/list
import gleam/result

@external(erlang, "io", "get_line")
fn get_line(prompt: String) -> dynamic.Dynamic

pub fn read_line() -> Result(String, Nil) {
  get_line("")
  |> dynamic.from()
  |> dynamic.string()
  |> result.nil_error()
}

pub fn read_all() -> List(String) {
  read_all_loop([])
}

fn read_all_loop(acc: List(String)) -> List(String) {
  case read_line() {
    Ok(line) -> read_all_loop([line, ..acc])
    Error(_) -> list.reverse(acc)
  }
}
