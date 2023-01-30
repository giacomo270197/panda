; ModuleID = "Shellcode"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define i32* @"add"(i32 %".1", i32 %".2")
{
.4:
  %".5" = alloca i32
  store i32 %".1", i32* %".5"
  %".7" = alloca i32
  store i32 %".2", i32* %".7"
  %".9" = alloca i32
  %".10" = add i32 %".1", %".2"
  store i32 %".10", i32* %".9"
  ret i32* %".9"
}

define i32 @"main"()
{
.2:
  %".3" = alloca i32
  %".4" = trunc i64 5 to i32
  store i32 %".4", i32* %".3"
  %".6" = alloca i32
  %".7" = trunc i64 6 to i32
  store i32 %".7", i32* %".6"
  %".9" = alloca i32*
  %".10" = call i32* @"add"(i32 %".4", i32 %".7")
  store i32* %".10", i32** %".9"
  %".12" = load i32, i32* %".10"
  ret i32 %".12"
}
