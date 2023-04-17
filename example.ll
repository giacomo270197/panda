; ModuleID = "Shellcode"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define i16 @"to_lowercase"(i16 %".1")
{
.3:
  %".4" = alloca i16
  store i16 %".1", i16* %".4"
  %".6" = load i16, i16* %".4"
  %".7" = icmp uge i16 %".6", 97
  br i1 %".7", label %".3.if", label %".3.else"
.3.if:
  %".9" = load i16, i16* %".4"
  %".10" = icmp ule i16 %".9", 122
  br i1 %".10", label %".3.if.if", label %".3.if.else"
.3.else:
  br label %".3.endif"
.3.endif:
  %".21" = load i16, i16* %".4"
  ret i16 %".21"
.3.if.if:
  %".12" = load i16, i16* %".4"
  %".13" = zext i16 %".12" to i64
  %".14" = sub i64 %".13", 32
  %".15" = trunc i64 %".14" to i16
  store i16 %".15", i16* %".4"
  br label %".3.if.endif"
.3.if.else:
  br label %".3.if.endif"
.3.if.endif:
  br label %".3.endif"
}

define i32 @"compute_function_hash"(i64 %".1")
{
.3:
  %".4" = alloca i64
  store i64 %".1", i64* %".4"
  %"hash" = alloca i32
  store i32 0, i32* %"hash"
  %"cnt" = alloca i8
  store i8 0, i8* %"cnt"
  %"char" = alloca i8
  %".8" = load i64, i64* %".4"
  %".9" = load i8, i8* %"cnt"
  %".10" = zext i8 %".9" to i64
  %".11" = add i64 %".8", %".10"
  %".12" = inttoptr i64 %".11" to i8*
  %".13" = load i8, i8* %".12"
  store i8 %".13", i8* %"char"
  %".15" = load i8, i8* %"char"
  %".16" = icmp ne i8 %".15", 0
  br i1 %".16", label %"loop_1", label %"loop_after_1"
loop_1:
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
  %".28" = load i8, i8* %"char"
  %".29" = zext i8 %".28" to i32
  %".30" = add i32 %".27", %".29"
  store i32 %".30", i32* %"hash"
  %".32" = load i8, i8* %"cnt"
  %".33" = zext i8 %".32" to i64
  %".34" = add i64 %".33", 1
  %".35" = trunc i64 %".34" to i8
  store i8 %".35", i8* %"cnt"
  %".37" = load i64, i64* %".4"
  %".38" = load i8, i8* %"cnt"
  %".39" = zext i8 %".38" to i64
  %".40" = add i64 %".37", %".39"
  %".41" = inttoptr i64 %".40" to i8*
  %".42" = load i8, i8* %".41"
  store i8 %".42", i8* %"char"
  %".44" = load i8, i8* %"char"
  %".45" = icmp ne i8 %".44", 0
  br i1 %".45", label %"loop_1", label %"loop_after_1"
loop_after_1:
  %".47" = load i32, i32* %"hash"
  ret i32 %".47"
}

define i64 @"find_actual_dll_name"(i64 %".1")
{
.3:
  %".4" = alloca i64
  store i64 %".1", i64* %".4"
  %"cnt" = alloca i64
  store i64 0, i64* %"cnt"
  %"last_backslash" = alloca i64
  store i64 0, i64* %"last_backslash"
  %"current_char" = alloca i8
  %".8" = load i64, i64* %".4"
  %".9" = load i64, i64* %"cnt"
  %".10" = add i64 %".8", %".9"
  %".11" = inttoptr i64 %".10" to i8*
  %".12" = load i8, i8* %".11"
  store i8 %".12", i8* %"current_char"
  %".14" = load i8, i8* %"current_char"
  %".15" = icmp ne i8 %".14", 0
  br i1 %".15", label %"loop_2", label %"loop_after_2"
loop_2:
  %".17" = load i8, i8* %"current_char"
  %".18" = icmp eq i8 %".17", 92
  br i1 %".18", label %"loop_2.if", label %"loop_2.else"
loop_after_2:
  %".38" = load i64, i64* %"last_backslash"
  %".39" = add i64 %".38", 2
  ret i64 %".39"
loop_2.if:
  %".20" = load i64, i64* %".4"
  %".21" = load i64, i64* %"cnt"
  %".22" = add i64 %".20", %".21"
  store i64 %".22", i64* %"last_backslash"
  br label %"loop_2.endif"
loop_2.else:
  br label %"loop_2.endif"
loop_2.endif:
  %".26" = load i64, i64* %"cnt"
  %".27" = add i64 %".26", 2
  store i64 %".27", i64* %"cnt"
  %".29" = load i64, i64* %".4"
  %".30" = load i64, i64* %"cnt"
  %".31" = add i64 %".29", %".30"
  %".32" = inttoptr i64 %".31" to i8*
  %".33" = load i8, i8* %".32"
  store i8 %".33", i8* %"current_char"
  %".35" = load i8, i8* %"current_char"
  %".36" = icmp ne i8 %".35", 0
  br i1 %".36", label %"loop_2", label %"loop_after_2"
}

define i32 @"compute_module_hash"(i64 %".1")
{
.3:
  %".4" = alloca i64
  store i64 %".1", i64* %".4"
  %"actual_name" = alloca i64
  %".6" = load i64, i64* %".4"
  %".7" = call i64 @"find_actual_dll_name"(i64 %".6")
  store i64 %".7", i64* %"actual_name"
  %"hash" = alloca i32
  store i32 0, i32* %"hash"
  %"cnt" = alloca i8
  store i8 0, i8* %"cnt"
  %"char" = alloca i16
  %".11" = load i64, i64* %"actual_name"
  %".12" = load i8, i8* %"cnt"
  %".13" = zext i8 %".12" to i64
  %".14" = add i64 %".11", %".13"
  %".15" = inttoptr i64 %".14" to i16*
  %".16" = load i16, i16* %".15"
  store i16 %".16", i16* %"char"
  %".18" = load i16, i16* %"char"
  %".19" = call i16 @"to_lowercase"(i16 %".18")
  store i16 %".19", i16* %"char"
  %".21" = load i16, i16* %"char"
  %".22" = icmp ne i16 %".21", 0
  br i1 %".22", label %"loop_3", label %"loop_after_3"
loop_3:
  %".24" = load i32, i32* %"hash"
  %".25" = zext i32 %".24" to i64
  %".26" = ashr i64 %".25", 13
  %".27" = load i32, i32* %"hash"
  %".28" = zext i32 %".27" to i64
  %".29" = shl i64 %".28", 19
  %".30" = or i64 %".26", %".29"
  %".31" = trunc i64 %".30" to i32
  store i32 %".31", i32* %"hash"
  %".33" = load i32, i32* %"hash"
  %".34" = load i16, i16* %"char"
  %".35" = zext i16 %".34" to i32
  %".36" = add i32 %".33", %".35"
  store i32 %".36", i32* %"hash"
  %".38" = load i8, i8* %"cnt"
  %".39" = zext i8 %".38" to i64
  %".40" = add i64 %".39", 2
  %".41" = trunc i64 %".40" to i8
  store i8 %".41", i8* %"cnt"
  %".43" = load i64, i64* %"actual_name"
  %".44" = load i8, i8* %"cnt"
  %".45" = zext i8 %".44" to i64
  %".46" = add i64 %".43", %".45"
  %".47" = inttoptr i64 %".46" to i16*
  %".48" = load i16, i16* %".47"
  store i16 %".48", i16* %"char"
  %".50" = load i16, i16* %"char"
  %".51" = icmp ne i16 %".50", 0
  br i1 %".51", label %"loop_3", label %"loop_after_3"
loop_after_3:
  %".53" = load i32, i32* %"hash"
  ret i32 %".53"
}

define i64 @"find_module_base"(i32 %".1")
{
.3:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %"pointer" = alloca i64
  store i64 0, i64* %"pointer"
  %".7" = load i64, i64* %"pointer"
  call void asm sideeffect "", "{rax}"
(i64 %".7")
  call void asm  "mov %gs:48, %rax", ""
()
  %".10" = call i64 asm  "", "={rax}"
()
  store i64 %".10", i64* %"pointer"
  %".12" = load i64, i64* %"pointer"
  %".13" = add i64 %".12", 96
  %".14" = inttoptr i64 %".13" to i64*
  %".15" = load i64, i64* %".14"
  store i64 %".15", i64* %"pointer"
  %".17" = load i64, i64* %"pointer"
  %".18" = add i64 %".17", 24
  %".19" = inttoptr i64 %".18" to i64*
  %".20" = load i64, i64* %".19"
  store i64 %".20", i64* %"pointer"
  %".22" = load i64, i64* %"pointer"
  %".23" = add i64 %".22", 32
  %".24" = inttoptr i64 %".23" to i64*
  %".25" = load i64, i64* %".24"
  store i64 %".25", i64* %"pointer"
  %"guard" = alloca i8
  store i8 0, i8* %"guard"
  %".28" = load i8, i8* %"guard"
  %".29" = icmp eq i8 %".28", 0
  br i1 %".29", label %"loop_4", label %"loop_after_4"
loop_4:
  %"table_entry" = alloca i64
  %".31" = load i64, i64* %"pointer"
  %".32" = sub i64 %".31", 16
  %".33" = inttoptr i64 %".32" to i64*
  %".34" = load i64, i64* %".33"
  store i64 %".34", i64* %"table_entry"
  %"name" = alloca i64
  %".36" = load i64, i64* %"table_entry"
  %".37" = add i64 %".36", 80
  %".38" = inttoptr i64 %".37" to i64*
  %".39" = load i64, i64* %".38"
  store i64 %".39", i64* %"name"
  %"first_char" = alloca i16
  %".41" = load i64, i64* %"name"
  %".42" = inttoptr i64 %".41" to i16*
  %".43" = load i16, i16* %".42"
  store i16 %".43", i16* %"first_char"
  %".45" = load i16, i16* %"first_char"
  %".46" = icmp eq i16 %".45", 0
  br i1 %".46", label %"loop_4.if", label %"loop_4.else"
loop_after_4:
  ret i64 0
loop_4.if:
  ret i64 0
loop_4.else:
  br label %"loop_4.endif"
loop_4.endif:
  %"computed_hash" = alloca i32
  %".50" = load i64, i64* %"name"
  %".51" = call i32 @"compute_module_hash"(i64 %".50")
  store i32 %".51", i32* %"computed_hash"
  %".53" = load i32, i32* %"computed_hash"
  %".54" = load i32, i32* %".4"
  %".55" = icmp eq i32 %".53", %".54"
  br i1 %".55", label %"loop_4.endif.if", label %"loop_4.endif.else"
loop_4.endif.if:
  %".57" = load i64, i64* %"table_entry"
  %".58" = add i64 %".57", 48
  %".59" = inttoptr i64 %".58" to i64*
  %".60" = load i64, i64* %".59"
  ret i64 %".60"
loop_4.endif.else:
  br label %"loop_4.endif.endif"
loop_4.endif.endif:
  %".63" = load i64, i64* %"pointer"
  %".64" = inttoptr i64 %".63" to i64*
  %".65" = load i64, i64* %".64"
  store i64 %".65", i64* %"pointer"
  %".67" = load i8, i8* %"guard"
  %".68" = icmp eq i8 %".67", 0
  br i1 %".68", label %"loop_4", label %"loop_after_4"
}

define i64 @"find_function"(i32 %".1", i32 %".2", i8* %".3")
{
.5:
  %".6" = alloca i32
  store i32 %".1", i32* %".6"
  %".8" = alloca i32
  store i32 %".2", i32* %".8"
  %".10" = alloca i8*
  store i8* %".3", i8** %".10"
  %"base_address" = alloca i64
  %".12" = load i32, i32* %".8"
  %".13" = call i64 @"find_module_base"(i32 %".12")
  store i64 %".13", i64* %"base_address"
  %".15" = load i64, i64* %"base_address"
  %".16" = icmp eq i64 %".15", 0
  br i1 %".16", label %".5.if", label %".5.else"
.5.if:
  %"load_library" = alloca i64
  %".18" = load i8*, i8** %".10"
  %".19" = call i64 @"find_function"(i32 3960360590, i32 1848363543, i8* %".18")
  store i64 %".19", i64* %"load_library"
  %".21" = load i64, i64* %"load_library"
  call void asm sideeffect "", "{rax}"
(i64 %".21")
  %".23" = load i8*, i8** %".10"
  %".24" = ptrtoint i8* %".23" to i64
  call void asm sideeffect "", "{rcx}"
(i64 %".24")
  call void asm  "call rax", ""
()
  %".27" = call i64 asm  "", "={rax}"
()
  store i64 %".27", i64* %"base_address"
  br label %".5.endif"
.5.else:
  br label %".5.endif"
.5.endif:
  %"pe_signature" = alloca i32
  %".31" = load i64, i64* %"base_address"
  %".32" = add i64 %".31", 60
  %".33" = inttoptr i64 %".32" to i32*
  %".34" = load i32, i32* %".33"
  store i32 %".34", i32* %"pe_signature"
  %".36" = load i32, i32* %"pe_signature"
  %".37" = zext i32 %".36" to i64
  %".38" = alloca i64
  store i64 %".37", i64* %".38"
  %".40" = load i64, i64* %".38"
  %".41" = load i64, i64* %"base_address"
  %".42" = add i64 %".40", %".41"
  store i64 %".42", i64* %".38"
  %"export_table_directory" = alloca i32
  %".44" = load i64, i64* %".38"
  %".45" = add i64 %".44", 136
  %".46" = inttoptr i64 %".45" to i32*
  %".47" = load i32, i32* %".46"
  store i32 %".47", i32* %"export_table_directory"
  %".49" = load i32, i32* %"export_table_directory"
  %".50" = zext i32 %".49" to i64
  %".51" = alloca i64
  store i64 %".50", i64* %".51"
  %".53" = load i64, i64* %".51"
  %".54" = load i64, i64* %"base_address"
  %".55" = add i64 %".53", %".54"
  store i64 %".55", i64* %".51"
  %"number_of_names" = alloca i32
  %".57" = load i64, i64* %".51"
  %".58" = add i64 %".57", 24
  %".59" = inttoptr i64 %".58" to i32*
  %".60" = load i32, i32* %".59"
  store i32 %".60", i32* %"number_of_names"
  %"address_of_names" = alloca i32
  %".62" = load i64, i64* %".51"
  %".63" = add i64 %".62", 32
  %".64" = inttoptr i64 %".63" to i32*
  %".65" = load i32, i32* %".64"
  store i32 %".65", i32* %"address_of_names"
  %".67" = load i32, i32* %"address_of_names"
  %".68" = zext i32 %".67" to i64
  %".69" = alloca i64
  store i64 %".68", i64* %".69"
  %".71" = load i64, i64* %".69"
  %".72" = load i64, i64* %"base_address"
  %".73" = add i64 %".71", %".72"
  store i64 %".73", i64* %".69"
  %".75" = load i32, i32* %"number_of_names"
  %".76" = zext i32 %".75" to i64
  %".77" = sub i64 %".76", 1
  %".78" = trunc i64 %".77" to i32
  store i32 %".78", i32* %"number_of_names"
  %".80" = load i32, i32* %"number_of_names"
  %".81" = icmp ugt i32 %".80", 0
  br i1 %".81", label %"loop_5", label %"loop_after_5"
loop_5:
  %"symbol_name_offset" = alloca i32
  %".83" = load i64, i64* %".69"
  %".84" = load i32, i32* %"number_of_names"
  %".85" = zext i32 %".84" to i64
  %".86" = mul i64 %".85", 4
  %".87" = add i64 %".83", %".86"
  %".88" = inttoptr i64 %".87" to i32*
  %".89" = load i32, i32* %".88"
  store i32 %".89", i32* %"symbol_name_offset"
  %"symbol_name" = alloca i64
  %".91" = load i64, i64* %"base_address"
  %".92" = load i32, i32* %"symbol_name_offset"
  %".93" = zext i32 %".92" to i64
  %".94" = add i64 %".91", %".93"
  store i64 %".94", i64* %"symbol_name"
  %"computed" = alloca i32
  %".96" = load i64, i64* %"symbol_name"
  %".97" = call i32 @"compute_function_hash"(i64 %".96")
  store i32 %".97", i32* %"computed"
  %".99" = load i32, i32* %"computed"
  %".100" = load i32, i32* %".6"
  %".101" = icmp eq i32 %".99", %".100"
  br i1 %".101", label %"loop_5.if", label %"loop_5.else"
loop_after_5:
  ret i64 0
loop_5.if:
  %"address_of_name_ordinal" = alloca i32
  %".103" = load i64, i64* %".51"
  %".104" = add i64 %".103", 36
  %".105" = inttoptr i64 %".104" to i32*
  %".106" = load i32, i32* %".105"
  store i32 %".106", i32* %"address_of_name_ordinal"
  %".108" = load i32, i32* %"address_of_name_ordinal"
  %".109" = zext i32 %".108" to i64
  %".110" = alloca i64
  store i64 %".109", i64* %".110"
  %".112" = load i64, i64* %".110"
  %".113" = load i64, i64* %"base_address"
  %".114" = add i64 %".112", %".113"
  store i64 %".114", i64* %".110"
  %"ordinal" = alloca i16
  %".116" = load i64, i64* %".110"
  %".117" = load i32, i32* %"number_of_names"
  %".118" = zext i32 %".117" to i64
  %".119" = mul i64 2, %".118"
  %".120" = add i64 %".116", %".119"
  %".121" = inttoptr i64 %".120" to i16*
  %".122" = load i16, i16* %".121"
  store i16 %".122", i16* %"ordinal"
  %"address_of_functions" = alloca i32
  %".124" = load i64, i64* %".51"
  %".125" = add i64 %".124", 28
  %".126" = inttoptr i64 %".125" to i32*
  %".127" = load i32, i32* %".126"
  store i32 %".127", i32* %"address_of_functions"
  %".129" = load i32, i32* %"address_of_functions"
  %".130" = zext i32 %".129" to i64
  %".131" = alloca i64
  store i64 %".130", i64* %".131"
  %".133" = load i64, i64* %".131"
  %".134" = load i64, i64* %"base_address"
  %".135" = add i64 %".133", %".134"
  store i64 %".135", i64* %".131"
  %"function_address" = alloca i32
  %".137" = load i64, i64* %".131"
  %".138" = load i16, i16* %"ordinal"
  %".139" = zext i16 %".138" to i64
  %".140" = mul i64 4, %".139"
  %".141" = add i64 %".137", %".140"
  %".142" = inttoptr i64 %".141" to i32*
  %".143" = load i32, i32* %".142"
  store i32 %".143", i32* %"function_address"
  %".145" = load i32, i32* %"function_address"
  %".146" = zext i32 %".145" to i64
  %".147" = alloca i64
  store i64 %".146", i64* %".147"
  %".149" = load i64, i64* %".147"
  %".150" = load i64, i64* %"base_address"
  %".151" = add i64 %".149", %".150"
  store i64 %".151", i64* %".147"
  %".153" = load i64, i64* %".147"
  ret i64 %".153"
loop_5.else:
  br label %"loop_5.endif"
loop_5.endif:
  %".156" = load i32, i32* %"number_of_names"
  %".157" = zext i32 %".156" to i64
  %".158" = sub i64 %".157", 1
  %".159" = trunc i64 %".158" to i32
  store i32 %".159", i32* %"number_of_names"
  %".161" = load i32, i32* %"number_of_names"
  %".162" = icmp ugt i32 %".161", 0
  br i1 %".162", label %"loop_5", label %"loop_after_5"
}

define i64 @"testPointer"(i64* %".1")
{
.3:
  %".4" = alloca i64*
  store i64* %".1", i64** %".4"
  %".6" = load i64*, i64** %".4"
  store i64 5, i64* %".6"
  ret i64 0
}

define i64 @"main"()
{
.2:
  %"test" = alloca i64
  store i64 4, i64* %"test"
  %".4" = call i64 @"testPointer"(i64* %"test")
  %".5" = alloca [12 x i8]
  store [12 x i8] zeroinitializer, [12 x i8]* %".5"
  %".7" = getelementptr inbounds [12 x i8], [12 x i8]* %".5", i8 0, i8 0
  store i8 110, i8* %".7"
  %".9" = getelementptr inbounds [12 x i8], [12 x i8]* %".5", i8 0, i8 1
  store i8 111, i8* %".9"
  %".11" = getelementptr inbounds [12 x i8], [12 x i8]* %".5", i8 0, i8 2
  store i8 116, i8* %".11"
  %".13" = getelementptr inbounds [12 x i8], [12 x i8]* %".5", i8 0, i8 3
  store i8 101, i8* %".13"
  %".15" = getelementptr inbounds [12 x i8], [12 x i8]* %".5", i8 0, i8 4
  store i8 112, i8* %".15"
  %".17" = getelementptr inbounds [12 x i8], [12 x i8]* %".5", i8 0, i8 5
  store i8 97, i8* %".17"
  %".19" = getelementptr inbounds [12 x i8], [12 x i8]* %".5", i8 0, i8 6
  store i8 100, i8* %".19"
  %".21" = getelementptr inbounds [12 x i8], [12 x i8]* %".5", i8 0, i8 7
  store i8 46, i8* %".21"
  %".23" = getelementptr inbounds [12 x i8], [12 x i8]* %".5", i8 0, i8 8
  store i8 101, i8* %".23"
  %".25" = getelementptr inbounds [12 x i8], [12 x i8]* %".5", i8 0, i8 9
  store i8 120, i8* %".25"
  %".27" = getelementptr inbounds [12 x i8], [12 x i8]* %".5", i8 0, i8 10
  store i8 101, i8* %".27"
  %".29" = getelementptr inbounds [12 x i8], [12 x i8]* %".5", i8 0, i8 11
  store i8 0, i8* %".29"
  %".31" = alloca [28 x i32]
  store [28 x i32] zeroinitializer, [28 x i32]* %".31"
  %".33" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 0
  store i32 0, i32* %".33"
  %".35" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 1
  store i32 0, i32* %".35"
  %".37" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 2
  store i32 0, i32* %".37"
  %".39" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 3
  store i32 0, i32* %".39"
  %".41" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 4
  store i32 0, i32* %".41"
  %".43" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 5
  store i32 0, i32* %".43"
  %".45" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 6
  store i32 0, i32* %".45"
  %".47" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 7
  store i32 0, i32* %".47"
  %".49" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 8
  store i32 0, i32* %".49"
  %".51" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 9
  store i32 0, i32* %".51"
  %".53" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 10
  store i32 0, i32* %".53"
  %".55" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 11
  store i32 0, i32* %".55"
  %".57" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 12
  store i32 0, i32* %".57"
  %".59" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 13
  store i32 0, i32* %".59"
  %".61" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 14
  store i32 0, i32* %".61"
  %".63" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 15
  store i32 0, i32* %".63"
  %".65" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 16
  store i32 0, i32* %".65"
  %".67" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 17
  store i32 0, i32* %".67"
  %".69" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 18
  store i32 0, i32* %".69"
  %".71" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 19
  store i32 0, i32* %".71"
  %".73" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 20
  store i32 0, i32* %".73"
  %".75" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 21
  store i32 0, i32* %".75"
  %".77" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 22
  store i32 0, i32* %".77"
  %".79" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 23
  store i32 0, i32* %".79"
  %".81" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 24
  store i32 0, i32* %".81"
  %".83" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 25
  store i32 0, i32* %".83"
  %".85" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 26
  store i32 0, i32* %".85"
  %".87" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i32 0, i32 27
  store i32 0, i32* %".87"
  %".89" = getelementptr inbounds [28 x i32], [28 x i32]* %".31", i8 0, i64 0
  store i32 104, i32* %".89"
  %".91" = alloca [4 x i64]
  store [4 x i64] zeroinitializer, [4 x i64]* %".91"
  %".93" = getelementptr inbounds [4 x i64], [4 x i64]* %".91", i64 0, i64 0
  store i64 0, i64* %".93"
  %".95" = getelementptr inbounds [4 x i64], [4 x i64]* %".91", i64 0, i64 1
  store i64 0, i64* %".95"
  %".97" = getelementptr inbounds [4 x i64], [4 x i64]* %".91", i64 0, i64 2
  store i64 0, i64* %".97"
  %".99" = getelementptr inbounds [4 x i64], [4 x i64]* %".91", i64 0, i64 3
  store i64 0, i64* %".99"
  %".101" = alloca [13 x i8]
  store [13 x i8] c"kernel32.dll\00", [13 x i8]* %".101"
  %".103" = bitcast [13 x i8]* %".101" to i8*
  %".104" = call ccc i64 @"find_function"(i32 380894834, i32 1848363543, i8* %".103")
  %".105" = getelementptr [12 x i8], [12 x i8]* %".5", i8 0, i8 0
  %".106" = getelementptr [28 x i32], [28 x i32]* %".31", i8 0, i8 0
  %".107" = getelementptr [4 x i64], [4 x i64]* %".91", i8 0, i8 0
  %".108" = call i64 @"call_CreateProcessA"(i32 0, i8* %".105", i32 0, i32 0, i32 0, i32 0, i32 0, i32 0, i32* %".106", i64* %".107", i64 %".104")
  ret i64 0
}

define i64 @"call_CreateProcessA"(i32 %".1", i8* %".2", i32 %".3", i32 %".4", i32 %".5", i32 %".6", i32 %".7", i32 %".8", i32* %".9", i64* %".10", i64 %".11")
{
.13:
  %".14" = alloca i32
  store i32 %".1", i32* %".14"
  %".16" = alloca i8*
  store i8* %".2", i8** %".16"
  %".18" = alloca i32
  store i32 %".3", i32* %".18"
  %".20" = alloca i32
  store i32 %".4", i32* %".20"
  %".22" = alloca i32
  store i32 %".5", i32* %".22"
  %".24" = alloca i32
  store i32 %".6", i32* %".24"
  %".26" = alloca i32
  store i32 %".7", i32* %".26"
  %".28" = alloca i32
  store i32 %".8", i32* %".28"
  %".30" = alloca i32*
  store i32* %".9", i32** %".30"
  %".32" = alloca i64*
  store i64* %".10", i64** %".32"
  %".34" = alloca i64
  store i64 %".11", i64* %".34"
  %"out" = alloca i64
  store i64 0, i64* %"out"
  %".37" = load i64, i64* %".34"
  call void asm sideeffect "", "{rax}"
(i64 %".37")
  call void asm  "mov %rsp,%rsi
push %rsi
push 112(%rsi)
push 104(%rsi)
push 96(%rsi)
push 88(%rsi)
push 80(%rsi)
push 72(%rsi)
push 64(%rsi)
push 56(%rsi)
push 48(%rsi)
push 40(%rsi)
call rax
pop %rsi
pop %rsi
pop %rsi
pop %rsi
pop %rsi
pop %rsi
pop %rsi
pop %rsi
pop %rsi
pop %rsi
pop %rsi
", ""
()
  %".40" = call i64 asm  "", "={rax}"
()
  store i64 %".40", i64* %"out"
  %".42" = load i64, i64* %"out"
  ret i64 %".42"
}
