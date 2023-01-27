; ModuleID = "Shellcode"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define i32 @"helper"(i32 %".1", i32 %".2")
{
.4:
  %".5" = alloca i32
  store i32 %".1", i32* %".5"
  %".7" = alloca i32
  store i32 %".2", i32* %".7"
  %".9" = trunc i64 2 to i32
  %".10" = add i32 %".2", %".9"
  store i32 %".10", i32* %".5"
  ret i32 %".10"
}

define i32 @"main"()
{
.2:
  %".3" = alloca i32
  %".4" = trunc i64 4 to i32
  store i32 %".4", i32* %".3"
  %".6" = alloca i32
  %".7" = trunc i64 3 to i32
  store i32 %".7", i32* %".6"
  %".9" = alloca i32
  %".10" = call i32 @"helper"(i32 %".4", i32 %".7")
  store i32 %".10", i32* %".9"
  ret i32 %".10"
}
