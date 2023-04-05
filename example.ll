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
  %".8" = load i64, i64* %"base_address"
  %".9" = icmp eq i64 %".8", 0
  br i1 %".9", label %".5.if", label %".5.else"
.5.if:
  %"load_library" = alloca i64
  %".11" = call i64 @"find_function"(i32 3960360590, i32 1848363543, i8* %".3")
  store i64 %".11", i64* %"load_library"
  %".13" = load i64, i64* %"load_library"
  call void asm sideeffect "", "{rax}"
(i64 %".13")
  %".15" = ptrtoint i8* %".3" to i64
  call void asm sideeffect "", "{rbx}"
(i64 %".15")
  call void asm  "call rax", ""
()
  %".18" = call i64 asm  "", "={rax}"
()
  store i64 %".18", i64* %"base_address"
  br label %".5.endif"
.5.else:
  br label %".5.endif"
.5.endif:
  %"pe_signature" = alloca i32
  %".22" = load i64, i64* %"base_address"
  %".23" = add i64 %".22", 60
  %".24" = inttoptr i64 %".23" to i32*
  %".25" = load i32, i32* %".24"
  store i32 %".25", i32* %"pe_signature"
  %".27" = load i32, i32* %"pe_signature"
  %".28" = zext i32 %".27" to i64
  %".29" = alloca i64
  store i64 %".28", i64* %".29"
  %".31" = load i64, i64* %".29"
  %".32" = load i64, i64* %"base_address"
  %".33" = add i64 %".31", %".32"
  store i64 %".33", i64* %".29"
  %"export_table_directory" = alloca i32
  %".35" = load i64, i64* %".29"
  %".36" = add i64 %".35", 136
  %".37" = inttoptr i64 %".36" to i32*
  %".38" = load i32, i32* %".37"
  store i32 %".38", i32* %"export_table_directory"
  %".40" = load i32, i32* %"export_table_directory"
  %".41" = zext i32 %".40" to i64
  %".42" = alloca i64
  store i64 %".41", i64* %".42"
  %".44" = load i64, i64* %".42"
  %".45" = load i64, i64* %"base_address"
  %".46" = add i64 %".44", %".45"
  store i64 %".46", i64* %".42"
  %"number_of_names" = alloca i32
  %".48" = load i64, i64* %".42"
  %".49" = add i64 %".48", 24
  %".50" = inttoptr i64 %".49" to i32*
  %".51" = load i32, i32* %".50"
  store i32 %".51", i32* %"number_of_names"
  %"address_of_names" = alloca i32
  %".53" = load i64, i64* %".42"
  %".54" = add i64 %".53", 32
  %".55" = inttoptr i64 %".54" to i32*
  %".56" = load i32, i32* %".55"
  store i32 %".56", i32* %"address_of_names"
  %".58" = load i32, i32* %"address_of_names"
  %".59" = zext i32 %".58" to i64
  %".60" = alloca i64
  store i64 %".59", i64* %".60"
  %".62" = load i64, i64* %".60"
  %".63" = load i64, i64* %"base_address"
  %".64" = add i64 %".62", %".63"
  store i64 %".64", i64* %".60"
  %".66" = load i32, i32* %"number_of_names"
  %".67" = zext i32 %".66" to i64
  %".68" = sub i64 %".67", 1
  %".69" = trunc i64 %".68" to i32
  store i32 %".69", i32* %"number_of_names"
  %".71" = load i32, i32* %"number_of_names"
  %".72" = icmp ugt i32 %".71", 0
  br i1 %".72", label %"loop_5", label %"loop_after_5"
loop_5:
  %"symbol_name_offset" = alloca i32
  %".74" = load i64, i64* %".60"
  %".75" = load i32, i32* %"number_of_names"
  %".76" = zext i32 %".75" to i64
  %".77" = mul i64 %".76", 4
  %".78" = add i64 %".74", %".77"
  %".79" = inttoptr i64 %".78" to i32*
  %".80" = load i32, i32* %".79"
  store i32 %".80", i32* %"symbol_name_offset"
  %"symbol_name" = alloca i64
  %".82" = load i64, i64* %"base_address"
  %".83" = load i32, i32* %"symbol_name_offset"
  %".84" = zext i32 %".83" to i64
  %".85" = add i64 %".82", %".84"
  store i64 %".85", i64* %"symbol_name"
  %"computed" = alloca i32
  %".87" = load i64, i64* %"symbol_name"
  %".88" = call i32 @"compute_function_hash"(i64 %".87")
  store i32 %".88", i32* %"computed"
  %".90" = load i32, i32* %"computed"
  %".91" = icmp eq i32 %".90", %".1"
  br i1 %".91", label %"loop_5.if", label %"loop_5.else"
loop_after_5:
  ret i64 0
loop_5.if:
  %"address_of_name_ordinal" = alloca i32
  %".93" = load i64, i64* %".42"
  %".94" = add i64 %".93", 36
  %".95" = inttoptr i64 %".94" to i32*
  %".96" = load i32, i32* %".95"
  store i32 %".96", i32* %"address_of_name_ordinal"
  %".98" = load i32, i32* %"address_of_name_ordinal"
  %".99" = zext i32 %".98" to i64
  %".100" = alloca i64
  store i64 %".99", i64* %".100"
  %".102" = load i64, i64* %".100"
  %".103" = load i64, i64* %"base_address"
  %".104" = add i64 %".102", %".103"
  store i64 %".104", i64* %".100"
  %"ordinal" = alloca i16
  %".106" = load i64, i64* %".100"
  %".107" = load i32, i32* %"number_of_names"
  %".108" = zext i32 %".107" to i64
  %".109" = mul i64 2, %".108"
  %".110" = add i64 %".106", %".109"
  %".111" = inttoptr i64 %".110" to i16*
  %".112" = load i16, i16* %".111"
  store i16 %".112", i16* %"ordinal"
  %"address_of_functions" = alloca i32
  %".114" = load i64, i64* %".42"
  %".115" = add i64 %".114", 28
  %".116" = inttoptr i64 %".115" to i32*
  %".117" = load i32, i32* %".116"
  store i32 %".117", i32* %"address_of_functions"
  %".119" = load i32, i32* %"address_of_functions"
  %".120" = zext i32 %".119" to i64
  %".121" = alloca i64
  store i64 %".120", i64* %".121"
  %".123" = load i64, i64* %".121"
  %".124" = load i64, i64* %"base_address"
  %".125" = add i64 %".123", %".124"
  store i64 %".125", i64* %".121"
  %"function_address" = alloca i32
  %".127" = load i64, i64* %".121"
  %".128" = load i16, i16* %"ordinal"
  %".129" = zext i16 %".128" to i64
  %".130" = mul i64 4, %".129"
  %".131" = add i64 %".127", %".130"
  %".132" = inttoptr i64 %".131" to i32*
  %".133" = load i32, i32* %".132"
  store i32 %".133", i32* %"function_address"
  %".135" = load i32, i32* %"function_address"
  %".136" = zext i32 %".135" to i64
  %".137" = alloca i64
  store i64 %".136", i64* %".137"
  %".139" = load i64, i64* %".137"
  %".140" = load i64, i64* %"base_address"
  %".141" = add i64 %".139", %".140"
  store i64 %".141", i64* %".137"
  %".143" = load i64, i64* %".137"
  ret i64 %".143"
loop_5.else:
  br label %"loop_5.endif"
loop_5.endif:
  %".146" = load i32, i32* %"number_of_names"
  %".147" = zext i32 %".146" to i64
  %".148" = sub i64 %".147", 1
  %".149" = trunc i64 %".148" to i32
  store i32 %".149", i32* %"number_of_names"
  %".151" = load i32, i32* %"number_of_names"
  %".152" = icmp ugt i32 %".151", 0
  br i1 %".152", label %"loop_5", label %"loop_after_5"
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
