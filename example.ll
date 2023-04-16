; ModuleID = "Shellcode"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define i8 @"test"(i64* %".1")
{
.3:
  %".4" = alloca i64*
  store i64* %".1", i64** %".4"
  store i64* 7, i64** %".4"
  store i64* 7, i64** %".4"
  ret i8 0
}

define i64 @"main"()
{
.2:
  %"a" = alloca i64
  store i64 5, i64* %"a"
  %"b" = alloca i64*
  store i64* %"a", i64** %"b"
  store i64* %"a", i64** %"b"
  %".6" = load i64*, i64** %"b"
  %".7" = call i8 @"test"(i64* %".6")
  ret i64 0
}
