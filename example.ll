; ModuleID = "Shellcode"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define i32 @"compute_function_hash"(i64 %".1")
{
.3:
  %"hash" = alloca i32
  store i32 0, i32* %"hash"
  %"cnt" = alloca i8
  store i8 0, i8* %"cnt"
  %"char" = alloca i8
  %".6" = load i8, i8* %"cnt"
  %".7" = zext i8 %".6" to i64
  %".8" = add i64 %".1", %".7"
  %".9" = inttoptr i64 %".8" to i8*
  %".10" = load i8, i8* %".9"
  store i8 %".10", i8* %"char"
  %".12" = load i8, i8* %"char"
  %".13" = icmp ne i8 %".12", 0
  br i1 %".13", label %"loop_1", label %"loop_after_1"
loop_1:
  %".15" = load i32, i32* %"hash"
  %".16" = zext i32 %".15" to i64
  %".17" = ashr i64 %".16", 13
  %".18" = load i32, i32* %"hash"
  %".19" = zext i32 %".18" to i64
  %".20" = shl i64 %".19", 19
  %".21" = or i64 %".17", %".20"
  %".22" = trunc i64 %".21" to i32
  store i32 %".22", i32* %"hash"
  %".24" = load i32, i32* %"hash"
  %".25" = load i8, i8* %"char"
  %".26" = zext i8 %".25" to i32
  %".27" = add i32 %".24", %".26"
  store i32 %".27", i32* %"hash"
  %".29" = load i8, i8* %"cnt"
  %".30" = zext i8 %".29" to i64
  %".31" = add i64 %".30", 1
  %".32" = trunc i64 %".31" to i8
  store i8 %".32", i8* %"cnt"
  %".34" = load i8, i8* %"cnt"
  %".35" = zext i8 %".34" to i64
  %".36" = add i64 %".1", %".35"
  %".37" = inttoptr i64 %".36" to i8*
  %".38" = load i8, i8* %".37"
  store i8 %".38", i8* %"char"
  %".40" = load i8, i8* %"char"
  %".41" = icmp ne i8 %".40", 0
  br i1 %".41", label %"loop_1", label %"loop_after_1"
loop_after_1:
  %".43" = load i32, i32* %"hash"
  ret i32 %".43"
}

define i64 @"find_actual_dll_name"(i64 %".1")
{
.3:
  %"cnt" = alloca i64
  store i64 0, i64* %"cnt"
  %"last_backslash" = alloca i64
  store i64 0, i64* %"last_backslash"
  %"current_char" = alloca i8
  %".6" = load i64, i64* %"cnt"
  %".7" = add i64 %".1", %".6"
  %".8" = inttoptr i64 %".7" to i8*
  %".9" = load i8, i8* %".8"
  store i8 %".9", i8* %"current_char"
  %".11" = load i8, i8* %"current_char"
  %".12" = icmp ne i8 %".11", 0
  br i1 %".12", label %"loop_2", label %"loop_after_2"
loop_2:
  %".14" = load i8, i8* %"current_char"
  %".15" = icmp eq i8 %".14", 92
  br i1 %".15", label %"loop_2.if", label %"loop_2.else"
loop_after_2:
  %".33" = load i64, i64* %"last_backslash"
  %".34" = add i64 %".33", 2
  ret i64 %".34"
loop_2.if:
  %".17" = load i64, i64* %"cnt"
  %".18" = add i64 %".1", %".17"
  store i64 %".18", i64* %"last_backslash"
  br label %"loop_2.endif"
loop_2.else:
  br label %"loop_2.endif"
loop_2.endif:
  %".22" = load i64, i64* %"cnt"
  %".23" = add i64 %".22", 2
  store i64 %".23", i64* %"cnt"
  %".25" = load i64, i64* %"cnt"
  %".26" = add i64 %".1", %".25"
  %".27" = inttoptr i64 %".26" to i8*
  %".28" = load i8, i8* %".27"
  store i8 %".28", i8* %"current_char"
  %".30" = load i8, i8* %"current_char"
  %".31" = icmp ne i8 %".30", 0
  br i1 %".31", label %"loop_2", label %"loop_after_2"
}

define i32 @"compute_module_hash"(i64 %".1")
{
.3:
  %"actual_name" = alloca i64
  %".4" = call i64 @"find_actual_dll_name"(i64 %".1")
  store i64 %".4", i64* %"actual_name"
  %"hash" = alloca i32
  store i32 0, i32* %"hash"
  %"cnt" = alloca i8
  store i8 0, i8* %"cnt"
  %"char" = alloca i16
  %".8" = load i64, i64* %"actual_name"
  %".9" = load i8, i8* %"cnt"
  %".10" = zext i8 %".9" to i64
  %".11" = add i64 %".8", %".10"
  %".12" = inttoptr i64 %".11" to i16*
  %".13" = load i16, i16* %".12"
  store i16 %".13", i16* %"char"
  %".15" = load i16, i16* %"char"
  %".16" = icmp ne i16 %".15", 0
  br i1 %".16", label %"loop_3", label %"loop_after_3"
loop_3:
  %".18" = load i32, i32* %"hash"
  %".19" = zext i32 %".18" to i64
  %".20" = ashr i64 %".19", 13
  %".21" = load i32, i32* %"hash"
  %".22" = zext i32 %".21" to i64
  %".23" = shl i64 %".22", 19
  %".24" = or i64 %".20", %".23"
  %".25" = trunc i64 %".24" to i32
  store i32 %".25", i32* %"hash"
  %".27" = load i32, i32* %"hash"
  %".28" = load i16, i16* %"char"
  %".29" = zext i16 %".28" to i32
  %".30" = add i32 %".27", %".29"
  store i32 %".30", i32* %"hash"
  %".32" = load i8, i8* %"cnt"
  %".33" = zext i8 %".32" to i64
  %".34" = add i64 %".33", 2
  %".35" = trunc i64 %".34" to i8
  store i8 %".35", i8* %"cnt"
  %".37" = load i64, i64* %"actual_name"
  %".38" = load i8, i8* %"cnt"
  %".39" = zext i8 %".38" to i64
  %".40" = add i64 %".37", %".39"
  %".41" = inttoptr i64 %".40" to i16*
  %".42" = load i16, i16* %".41"
  store i16 %".42", i16* %"char"
  %".44" = load i16, i16* %"char"
  %".45" = icmp ne i16 %".44", 0
  br i1 %".45", label %"loop_3", label %"loop_after_3"
loop_after_3:
  %".47" = load i32, i32* %"hash"
  ret i32 %".47"
}

define i64 @"find_module_base"(i32 %".1")
{
.3:
  %"pointer" = alloca i64
  store i64 0, i64* %"pointer"
  %".5" = load i64, i64* %"pointer"
  call void asm sideeffect "", "{rax}"
(i64 %".5")
  call void asm  "mov %gs:48, %rax", ""
()
  %".8" = call i64 asm  "", "={rax}"
()
  store i64 %".8", i64* %"pointer"
  %".10" = load i64, i64* %"pointer"
  %".11" = add i64 %".10", 96
  %".12" = inttoptr i64 %".11" to i64*
  %".13" = load i64, i64* %".12"
  store i64 %".13", i64* %"pointer"
  %".15" = load i64, i64* %"pointer"
  %".16" = add i64 %".15", 24
  %".17" = inttoptr i64 %".16" to i64*
  %".18" = load i64, i64* %".17"
  store i64 %".18", i64* %"pointer"
  %".20" = load i64, i64* %"pointer"
  %".21" = add i64 %".20", 32
  %".22" = inttoptr i64 %".21" to i64*
  %".23" = load i64, i64* %".22"
  store i64 %".23", i64* %"pointer"
  %"guard" = alloca i8
  store i8 0, i8* %"guard"
  %".26" = load i8, i8* %"guard"
  %".27" = icmp eq i8 %".26", 0
  br i1 %".27", label %"loop_4", label %"loop_after_4"
loop_4:
  %"table_entry" = alloca i64
  %".29" = load i64, i64* %"pointer"
  %".30" = sub i64 %".29", 16
  %".31" = inttoptr i64 %".30" to i64*
  %".32" = load i64, i64* %".31"
  store i64 %".32", i64* %"table_entry"
  %"name" = alloca i64
  %".34" = load i64, i64* %"table_entry"
  %".35" = add i64 %".34", 80
  %".36" = inttoptr i64 %".35" to i64*
  %".37" = load i64, i64* %".36"
  store i64 %".37", i64* %"name"
  %"computed_hash" = alloca i32
  %".39" = load i64, i64* %"name"
  %".40" = call i32 @"compute_module_hash"(i64 %".39")
  store i32 %".40", i32* %"computed_hash"
  %".42" = load i32, i32* %"computed_hash"
  %".43" = icmp eq i32 %".42", %".1"
  br i1 %".43", label %"loop_4.if", label %"loop_4.else"
loop_after_4:
  ret i64 0
loop_4.if:
  %".45" = load i64, i64* %"table_entry"
  %".46" = add i64 %".45", 48
  %".47" = inttoptr i64 %".46" to i64*
  %".48" = load i64, i64* %".47"
  ret i64 %".48"
loop_4.else:
  br label %"loop_4.endif"
loop_4.endif:
  %".51" = load i64, i64* %"pointer"
  %".52" = inttoptr i64 %".51" to i64*
  %".53" = load i64, i64* %".52"
  store i64 %".53", i64* %"pointer"
  %".55" = load i8, i8* %"guard"
  %".56" = icmp eq i8 %".55", 0
  br i1 %".56", label %"loop_4", label %"loop_after_4"
}

define i64 @"find_function"(i32 %".1", i32 %".2", i8* %".3")
{
.5:
  %"base_address" = alloca i64
  %".6" = call i64 @"find_module_base"(i32 %".2")
  store i64 %".6", i64* %"base_address"
  %"pe_signature" = alloca i32
  %".8" = load i64, i64* %"base_address"
  %".9" = add i64 %".8", 60
  %".10" = inttoptr i64 %".9" to i32*
  %".11" = load i32, i32* %".10"
  store i32 %".11", i32* %"pe_signature"
  %".13" = load i32, i32* %"pe_signature"
  %".14" = zext i32 %".13" to i64
  %".15" = alloca i64
  store i64 %".14", i64* %".15"
  %".17" = load i64, i64* %".15"
  %".18" = load i64, i64* %"base_address"
  %".19" = add i64 %".17", %".18"
  store i64 %".19", i64* %".15"
  %"export_table_directory" = alloca i32
  %".21" = load i64, i64* %".15"
  %".22" = add i64 %".21", 136
  %".23" = inttoptr i64 %".22" to i32*
  %".24" = load i32, i32* %".23"
  store i32 %".24", i32* %"export_table_directory"
  %".26" = load i32, i32* %"export_table_directory"
  %".27" = zext i32 %".26" to i64
  %".28" = alloca i64
  store i64 %".27", i64* %".28"
  %".30" = load i64, i64* %".28"
  %".31" = load i64, i64* %"base_address"
  %".32" = add i64 %".30", %".31"
  store i64 %".32", i64* %".28"
  %"number_of_names" = alloca i32
  %".34" = load i64, i64* %".28"
  %".35" = add i64 %".34", 24
  %".36" = inttoptr i64 %".35" to i32*
  %".37" = load i32, i32* %".36"
  store i32 %".37", i32* %"number_of_names"
  %"address_of_names" = alloca i32
  %".39" = load i64, i64* %".28"
  %".40" = add i64 %".39", 32
  %".41" = inttoptr i64 %".40" to i32*
  %".42" = load i32, i32* %".41"
  store i32 %".42", i32* %"address_of_names"
  %".44" = load i32, i32* %"address_of_names"
  %".45" = zext i32 %".44" to i64
  %".46" = alloca i64
  store i64 %".45", i64* %".46"
  %".48" = load i64, i64* %".46"
  %".49" = load i64, i64* %"base_address"
  %".50" = add i64 %".48", %".49"
  store i64 %".50", i64* %".46"
  %".52" = load i32, i32* %"number_of_names"
  %".53" = zext i32 %".52" to i64
  %".54" = sub i64 %".53", 1
  %".55" = trunc i64 %".54" to i32
  store i32 %".55", i32* %"number_of_names"
  %".57" = load i32, i32* %"number_of_names"
  %".58" = icmp ugt i32 %".57", 0
  br i1 %".58", label %"loop_5", label %"loop_after_5"
loop_5:
  %"symbol_name_offset" = alloca i32
  %".60" = load i64, i64* %".46"
  %".61" = load i32, i32* %"number_of_names"
  %".62" = zext i32 %".61" to i64
  %".63" = mul i64 %".62", 4
  %".64" = add i64 %".60", %".63"
  %".65" = inttoptr i64 %".64" to i32*
  %".66" = load i32, i32* %".65"
  store i32 %".66", i32* %"symbol_name_offset"
  %"symbol_name" = alloca i64
  %".68" = load i64, i64* %"base_address"
  %".69" = load i32, i32* %"symbol_name_offset"
  %".70" = zext i32 %".69" to i64
  %".71" = add i64 %".68", %".70"
  store i64 %".71", i64* %"symbol_name"
  %"computed" = alloca i32
  %".73" = load i64, i64* %"symbol_name"
  %".74" = call i32 @"compute_function_hash"(i64 %".73")
  store i32 %".74", i32* %"computed"
  %".76" = load i32, i32* %"computed"
  %".77" = icmp eq i32 %".76", %".1"
  br i1 %".77", label %"loop_5.if", label %"loop_5.else"
loop_after_5:
  ret i64 0
loop_5.if:
  %"address_of_name_ordinal" = alloca i32
  %".79" = load i64, i64* %".28"
  %".80" = add i64 %".79", 36
  %".81" = inttoptr i64 %".80" to i32*
  %".82" = load i32, i32* %".81"
  store i32 %".82", i32* %"address_of_name_ordinal"
  %".84" = load i32, i32* %"address_of_name_ordinal"
  %".85" = zext i32 %".84" to i64
  %".86" = alloca i64
  store i64 %".85", i64* %".86"
  %".88" = load i64, i64* %".86"
  %".89" = load i64, i64* %"base_address"
  %".90" = add i64 %".88", %".89"
  store i64 %".90", i64* %".86"
  %"ordinal" = alloca i16
  %".92" = load i64, i64* %".86"
  %".93" = load i32, i32* %"number_of_names"
  %".94" = zext i32 %".93" to i64
  %".95" = mul i64 2, %".94"
  %".96" = add i64 %".92", %".95"
  %".97" = inttoptr i64 %".96" to i16*
  %".98" = load i16, i16* %".97"
  store i16 %".98", i16* %"ordinal"
  %"address_of_functions" = alloca i32
  %".100" = load i64, i64* %".28"
  %".101" = add i64 %".100", 28
  %".102" = inttoptr i64 %".101" to i32*
  %".103" = load i32, i32* %".102"
  store i32 %".103", i32* %"address_of_functions"
  %".105" = load i32, i32* %"address_of_functions"
  %".106" = zext i32 %".105" to i64
  %".107" = alloca i64
  store i64 %".106", i64* %".107"
  %".109" = load i64, i64* %".107"
  %".110" = load i64, i64* %"base_address"
  %".111" = add i64 %".109", %".110"
  store i64 %".111", i64* %".107"
  %"function_address" = alloca i32
  %".113" = load i64, i64* %".107"
  %".114" = load i16, i16* %"ordinal"
  %".115" = zext i16 %".114" to i64
  %".116" = mul i64 4, %".115"
  %".117" = add i64 %".113", %".116"
  %".118" = inttoptr i64 %".117" to i32*
  %".119" = load i32, i32* %".118"
  store i32 %".119", i32* %"function_address"
  %".121" = load i32, i32* %"function_address"
  %".122" = zext i32 %".121" to i64
  %".123" = alloca i64
  store i64 %".122", i64* %".123"
  %".125" = load i64, i64* %".123"
  %".126" = load i64, i64* %"base_address"
  %".127" = add i64 %".125", %".126"
  store i64 %".127", i64* %".123"
  %".129" = load i64, i64* %".123"
  ret i64 %".129"
loop_5.else:
  br label %"loop_5.endif"
loop_5.endif:
  %".132" = load i32, i32* %"number_of_names"
  %".133" = zext i32 %".132" to i64
  %".134" = sub i64 %".133", 1
  %".135" = trunc i64 %".134" to i32
  store i32 %".135", i32* %"number_of_names"
  %".137" = load i32, i32* %"number_of_names"
  %".138" = icmp ugt i32 %".137", 0
  br i1 %".138", label %"loop_5", label %"loop_after_5"
}

define i32 @"main"()
{
.2:
  %"hash" = alloca i32
  store i32 1848363543, i32* %"hash"
  %".4" = alloca [9 x i8]
  store [9 x i8] zeroinitializer, [9 x i8]* %".4"
  %".6" = getelementptr inbounds [9 x i8], [9 x i8]* %".4", i8 0, i8 0
  store i8 107, i8* %".6"
  %".8" = getelementptr inbounds [9 x i8], [9 x i8]* %".4", i8 0, i8 1
  store i8 101, i8* %".8"
  %".10" = getelementptr inbounds [9 x i8], [9 x i8]* %".4", i8 0, i8 2
  store i8 114, i8* %".10"
  %".12" = getelementptr inbounds [9 x i8], [9 x i8]* %".4", i8 0, i8 3
  store i8 110, i8* %".12"
  %".14" = getelementptr inbounds [9 x i8], [9 x i8]* %".4", i8 0, i8 4
  store i8 101, i8* %".14"
  %".16" = getelementptr inbounds [9 x i8], [9 x i8]* %".4", i8 0, i8 5
  store i8 108, i8* %".16"
  %".18" = getelementptr inbounds [9 x i8], [9 x i8]* %".4", i8 0, i8 6
  store i8 51, i8* %".18"
  %".20" = getelementptr inbounds [9 x i8], [9 x i8]* %".4", i8 0, i8 7
  store i8 50, i8* %".20"
  %".22" = getelementptr inbounds [9 x i8], [9 x i8]* %".4", i8 0, i8 8
  store i8 0, i8* %".22"
  %"test" = alloca i64
  %".24" = load i32, i32* %"hash"
  %".25" = getelementptr [9 x i8], [9 x i8]* %".4", i8 0, i8 0
  %".26" = call i64 @"find_function"(i32 3960360590, i32 %".24", i8* %".25")
  store i64 %".26", i64* %"test"
  ret i32 0
}
