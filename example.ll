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
  ret i32 %".1"
}

define i32 @"main"()
{
.2:
  %".3" = alloca [4 x i32]
  store [4 x i32] zeroinitializer, [4 x i32]* %".3"
  %".5" = getelementptr inbounds [4 x i32], [4 x i32]* %".3", i32 0, i32 0
  store i32 1, i32* %".5"
  %".7" = getelementptr inbounds [4 x i32], [4 x i32]* %".3", i32 0, i32 1
  store i32 2, i32* %".7"
  %".9" = getelementptr inbounds [4 x i32], [4 x i32]* %".3", i32 0, i32 2
  store i32 3, i32* %".9"
  %".11" = getelementptr inbounds [4 x i32], [4 x i32]* %".3", i32 0, i32 3
  store i32 4, i32* %".11"
  %".13" = alloca i32
  %".14" = getelementptr inbounds [4 x i32], [4 x i32]* %".3", i8 0, i64 2
  %".15" = load i32, i32* %".14"
  store i32 %".15", i32* %".13"
  %".17" = getelementptr inbounds [4 x i32], [4 x i32]* %".3", i8 0, i64 3
  %".18" = trunc i64 3 to i32
  %".19" = add i32 %".15", %".18"
  store i32 %".19", i32* %".17"
  %".21" = getelementptr inbounds [4 x i32], [4 x i32]* %".3", i8 0, i64 3
  %".22" = load i32, i32* %".21"
  ret i32 %".22"
}
