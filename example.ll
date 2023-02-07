; ModuleID = "Shellcode"
target triple = "unknown-unknown-unknown"
target datalayout = ""

define i32 @"compute_function_hash"(i32 %".1")
{
.3:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %"hash" = alloca i32
  store i32 0, i32* %"hash"
  %"cnt" = alloca i8
  store i8 0, i8* %"cnt"
  %"char" = alloca i8
  %".8" = load i32, i32* %".4"
  %".9" = load i8, i8* %"cnt"
  %".10" = zext i8 %".9" to i32
  %".11" = add i32 %".8", %".10"
  %".12" = inttoptr i32 %".11" to i8*
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
  %".37" = load i32, i32* %".4"
  %".38" = load i8, i8* %"cnt"
  %".39" = zext i8 %".38" to i32
  %".40" = add i32 %".37", %".39"
  %".41" = inttoptr i32 %".40" to i8*
  %".42" = load i8, i8* %".41"
  store i8 %".42", i8* %"char"
  %".44" = load i8, i8* %"char"
  %".45" = icmp ne i8 %".44", 0
  br i1 %".45", label %"loop_1", label %"loop_after_1"
loop_after_1:
  %".47" = load i32, i32* %"hash"
  ret i32 %".47"
}

define i32 @"compute_module_hash"(i32 %".1")
{
.3:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %"hash" = alloca i32
  store i32 0, i32* %"hash"
  %"cnt" = alloca i8
  store i8 0, i8* %"cnt"
  %"char" = alloca i16
  %".8" = load i32, i32* %".4"
  %".9" = load i8, i8* %"cnt"
  %".10" = zext i8 %".9" to i32
  %".11" = add i32 %".8", %".10"
  %".12" = inttoptr i32 %".11" to i16*
  %".13" = load i16, i16* %".12"
  store i16 %".13", i16* %"char"
  %".15" = load i16, i16* %"char"
  %".16" = icmp ne i16 %".15", 0
  br i1 %".16", label %"loop_2", label %"loop_after_2"
loop_2:
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
  %".37" = load i32, i32* %".4"
  %".38" = load i8, i8* %"cnt"
  %".39" = zext i8 %".38" to i32
  %".40" = add i32 %".37", %".39"
  %".41" = inttoptr i32 %".40" to i16*
  %".42" = load i16, i16* %".41"
  store i16 %".42", i16* %"char"
  %".44" = load i16, i16* %"char"
  %".45" = icmp ne i16 %".44", 0
  br i1 %".45", label %"loop_2", label %"loop_after_2"
loop_after_2:
  %".47" = load i32, i32* %"hash"
  ret i32 %".47"
}

define i32 @"find_module_base"(i32 %".1")
{
.3:
  %".4" = alloca i32
  store i32 %".1", i32* %".4"
  %"pointer" = alloca i32
  store i32 0, i32* %"pointer"
  %".7" = load i32, i32* %"pointer"
  call void asm sideeffect "", "{eax}"
(i32 %".7")
  call void asm  "mov %fs:48, %eax", ""
()
  %".10" = call i32 asm  "", "={eax}"
()
  store i32 %".10", i32* %"pointer"
  %".12" = load i32, i32* %"pointer"
  %".13" = zext i32 %".12" to i64
  %".14" = add i64 %".13", 12
  %".15" = inttoptr i64 %".14" to i32*
  %".16" = load i32, i32* %".15"
  store i32 %".16", i32* %"pointer"
  %".18" = load i32, i32* %"pointer"
  %".19" = zext i32 %".18" to i64
  %".20" = add i64 %".19", 28
  %".21" = inttoptr i64 %".20" to i32*
  %".22" = load i32, i32* %".21"
  store i32 %".22", i32* %"pointer"
  %"base_address" = alloca i32
  %".24" = load i32, i32* %"pointer"
  %".25" = zext i32 %".24" to i64
  %".26" = add i64 %".25", 8
  %".27" = inttoptr i64 %".26" to i32*
  %".28" = load i32, i32* %".27"
  store i32 %".28", i32* %"base_address"
  %"module_name" = alloca i32
  %".30" = load i32, i32* %"pointer"
  %".31" = zext i32 %".30" to i64
  %".32" = add i64 %".31", 32
  %".33" = inttoptr i64 %".32" to i32*
  %".34" = load i32, i32* %".33"
  store i32 %".34", i32* %"module_name"
  %"guard" = alloca i8
  store i8 0, i8* %"guard"
  %".37" = load i8, i8* %"guard"
  %".38" = icmp eq i8 %".37", 0
  br i1 %".38", label %"loop_3", label %"loop_after_3"
loop_3:
  %".40" = load i32, i32* %"pointer"
  %".41" = inttoptr i32 %".40" to i32*
  %".42" = load i32, i32* %".41"
  store i32 %".42", i32* %"pointer"
  %".44" = load i32, i32* %"pointer"
  %".45" = zext i32 %".44" to i64
  %".46" = add i64 %".45", 8
  %".47" = inttoptr i64 %".46" to i32*
  %".48" = load i32, i32* %".47"
  store i32 %".48", i32* %"base_address"
  %".50" = load i32, i32* %"pointer"
  %".51" = zext i32 %".50" to i64
  %".52" = add i64 %".51", 32
  %".53" = inttoptr i64 %".52" to i32*
  %".54" = load i32, i32* %".53"
  store i32 %".54", i32* %"module_name"
  %".56" = load i32, i32* %"module_name"
  %".57" = icmp eq i32 %".56", 0
  br i1 %".57", label %"loop_3.if", label %"loop_3.else"
loop_after_3:
  ret i32 0
loop_3.if:
  ret i32 0
loop_3.else:
  br label %"loop_3.endif"
loop_3.endif:
  %"computed_hash" = alloca i32
  %".61" = load i32, i32* %"module_name"
  %".62" = call i32 @"compute_module_hash"(i32 %".61")
  store i32 %".62", i32* %"computed_hash"
  %".64" = load i32, i32* %"computed_hash"
  %".65" = load i32, i32* %".4"
  %".66" = icmp eq i32 %".64", %".65"
  br i1 %".66", label %"loop_3.endif.if", label %"loop_3.endif.else"
loop_3.endif.if:
  %".68" = load i32, i32* %"base_address"
  ret i32 %".68"
loop_3.endif.else:
  br label %"loop_3.endif.endif"
loop_3.endif.endif:
  %".71" = load i8, i8* %"guard"
  %".72" = icmp eq i8 %".71", 0
  br i1 %".72", label %"loop_3", label %"loop_after_3"
}

define i32 @"find_function"(i32 %".1", i32 %".2", i8* %".3")
{
.5:
  %".6" = alloca i32
  store i32 %".1", i32* %".6"
  %".8" = alloca i32
  store i32 %".2", i32* %".8"
  %".10" = alloca i8*
  store i8* %".3", i8** %".10"
  %"base_address" = alloca i32
  %".12" = load i32, i32* %".8"
  %".13" = call i32 @"find_module_base"(i32 %".12")
  store i32 %".13", i32* %"base_address"
  %".15" = load i32, i32* %"base_address"
  %".16" = icmp eq i32 %".15", 0
  br i1 %".16", label %".5.if", label %".5.else"
.5.if:
  %"load_library" = alloca i32
  %".18" = load i8*, i8** %".10"
  %".19" = call i32 @"find_function"(i32 3960360590, i32 1848363543, i8* %".18")
  store i32 %".19", i32* %"load_library"
  %".21" = load i8*, i8** %".10"
  %".22" = ptrtoint i8* %".21" to i32
  call void asm sideeffect "", "{ebx}"
(i32 %".22")
  call void asm  "push %ebx", ""
()
  %".25" = load i32, i32* %"load_library"
  call void asm sideeffect "", "{eax}"
(i32 %".25")
  call void asm  "call eax", ""
()
  %".28" = call i32 asm  "", "={eax}"
()
  store i32 %".28", i32* %"base_address"
  br label %".5.endif"
.5.else:
  br label %".5.endif"
.5.endif:
  %"pe_signature" = alloca i32
  %".32" = load i32, i32* %"base_address"
  %".33" = zext i32 %".32" to i64
  %".34" = add i64 %".33", 60
  %".35" = inttoptr i64 %".34" to i32*
  %".36" = load i32, i32* %".35"
  store i32 %".36", i32* %"pe_signature"
  %".38" = load i32, i32* %"pe_signature"
  %".39" = load i32, i32* %"base_address"
  %".40" = add i32 %".38", %".39"
  store i32 %".40", i32* %"pe_signature"
  %"export_table_directory" = alloca i32
  %".42" = load i32, i32* %"pe_signature"
  %".43" = zext i32 %".42" to i64
  %".44" = add i64 %".43", 120
  %".45" = inttoptr i64 %".44" to i32*
  %".46" = load i32, i32* %".45"
  store i32 %".46", i32* %"export_table_directory"
  %".48" = load i32, i32* %"export_table_directory"
  %".49" = load i32, i32* %"base_address"
  %".50" = add i32 %".48", %".49"
  store i32 %".50", i32* %"export_table_directory"
  %"number_of_names" = alloca i32
  %".52" = load i32, i32* %"export_table_directory"
  %".53" = zext i32 %".52" to i64
  %".54" = add i64 %".53", 24
  %".55" = inttoptr i64 %".54" to i32*
  %".56" = load i32, i32* %".55"
  store i32 %".56", i32* %"number_of_names"
  %"address_of_names" = alloca i32
  %".58" = load i32, i32* %"export_table_directory"
  %".59" = zext i32 %".58" to i64
  %".60" = add i64 %".59", 32
  %".61" = inttoptr i64 %".60" to i32*
  %".62" = load i32, i32* %".61"
  store i32 %".62", i32* %"address_of_names"
  %".64" = load i32, i32* %"address_of_names"
  %".65" = load i32, i32* %"base_address"
  %".66" = add i32 %".64", %".65"
  store i32 %".66", i32* %"address_of_names"
  %".68" = load i32, i32* %"number_of_names"
  %".69" = zext i32 %".68" to i64
  %".70" = sub i64 %".69", 1
  %".71" = trunc i64 %".70" to i32
  store i32 %".71", i32* %"number_of_names"
  %".73" = load i32, i32* %"number_of_names"
  %".74" = icmp ugt i32 %".73", 0
  br i1 %".74", label %"loop_4", label %"loop_after_4"
loop_4:
  %"symbol_name" = alloca i32
  %".76" = load i32, i32* %"address_of_names"
  %".77" = load i32, i32* %"number_of_names"
  %".78" = zext i32 %".77" to i64
  %".79" = mul i64 %".78", 4
  %".80" = zext i32 %".76" to i64
  %".81" = add i64 %".80", %".79"
  %".82" = trunc i64 %".81" to i32
  store i32 %".82", i32* %"symbol_name"
  %".84" = load i32, i32* %"base_address"
  %".85" = load i32, i32* %"symbol_name"
  %".86" = inttoptr i32 %".85" to i32*
  %".87" = load i32, i32* %".86"
  %".88" = add i32 %".84", %".87"
  store i32 %".88", i32* %"symbol_name"
  %"computed" = alloca i32
  %".90" = load i32, i32* %"symbol_name"
  %".91" = call i32 @"compute_function_hash"(i32 %".90")
  store i32 %".91", i32* %"computed"
  %".93" = load i32, i32* %"computed"
  %".94" = load i32, i32* %".6"
  %".95" = icmp eq i32 %".93", %".94"
  br i1 %".95", label %"loop_4.if", label %"loop_4.else"
loop_after_4:
  ret i32 0
loop_4.if:
  %"address_of_name_ordinal" = alloca i32
  %".97" = load i32, i32* %"export_table_directory"
  %".98" = zext i32 %".97" to i64
  %".99" = add i64 %".98", 36
  %".100" = inttoptr i64 %".99" to i32*
  %".101" = load i32, i32* %".100"
  store i32 %".101", i32* %"address_of_name_ordinal"
  %".103" = load i32, i32* %"address_of_name_ordinal"
  %".104" = load i32, i32* %"base_address"
  %".105" = add i32 %".103", %".104"
  store i32 %".105", i32* %"address_of_name_ordinal"
  %"ordinal" = alloca i16
  %".107" = load i32, i32* %"address_of_name_ordinal"
  %".108" = load i32, i32* %"number_of_names"
  %".109" = zext i32 %".108" to i64
  %".110" = mul i64 2, %".109"
  %".111" = zext i32 %".107" to i64
  %".112" = add i64 %".111", %".110"
  %".113" = inttoptr i64 %".112" to i16*
  %".114" = load i16, i16* %".113"
  store i16 %".114", i16* %"ordinal"
  %"address_of_functions" = alloca i32
  %".116" = load i32, i32* %"export_table_directory"
  %".117" = zext i32 %".116" to i64
  %".118" = add i64 %".117", 28
  %".119" = inttoptr i64 %".118" to i32*
  %".120" = load i32, i32* %".119"
  store i32 %".120", i32* %"address_of_functions"
  %".122" = load i32, i32* %"address_of_functions"
  %".123" = load i32, i32* %"base_address"
  %".124" = add i32 %".122", %".123"
  store i32 %".124", i32* %"address_of_functions"
  %"function_address" = alloca i32
  %".126" = load i32, i32* %"address_of_functions"
  %".127" = load i16, i16* %"ordinal"
  %".128" = zext i16 %".127" to i64
  %".129" = mul i64 4, %".128"
  %".130" = zext i32 %".126" to i64
  %".131" = add i64 %".130", %".129"
  %".132" = inttoptr i64 %".131" to i32*
  %".133" = load i32, i32* %".132"
  store i32 %".133", i32* %"function_address"
  %".135" = load i32, i32* %"function_address"
  %".136" = load i32, i32* %"base_address"
  %".137" = add i32 %".135", %".136"
  store i32 %".137", i32* %"function_address"
  %".139" = load i32, i32* %"function_address"
  ret i32 %".139"
loop_4.else:
  br label %"loop_4.endif"
loop_4.endif:
  %".142" = load i32, i32* %"number_of_names"
  %".143" = zext i32 %".142" to i64
  %".144" = sub i64 %".143", 1
  %".145" = trunc i64 %".144" to i32
  store i32 %".145", i32* %"number_of_names"
  %".147" = load i32, i32* %"number_of_names"
  %".148" = icmp ugt i32 %".147", 0
  br i1 %".148", label %"loop_4", label %"loop_after_4"
}

define i32 @"call_fun"(i32 %".1", i8* %".2", i8* %".3")
{
.5:
  %".6" = alloca i32
  store i32 %".1", i32* %".6"
  %".8" = alloca i8*
  store i8* %".2", i8** %".8"
  %".10" = alloca i8*
  store i8* %".3", i8** %".10"
  call void asm  "xor %eax, %eax", ""
()
  call void asm  "push %eax", ""
()
  %".14" = load i8*, i8** %".10"
  %".15" = ptrtoint i8* %".14" to i32
  call void asm sideeffect "", "{eax}"
(i32 %".15")
  call void asm  "push %eax", ""
()
  %".18" = load i8*, i8** %".8"
  %".19" = ptrtoint i8* %".18" to i32
  call void asm sideeffect "", "{eax}"
(i32 %".19")
  call void asm  "push %eax", ""
()
  call void asm  "xor %eax, %eax", ""
()
  call void asm  "push %eax", ""
()
  %".24" = load i32, i32* %".6"
  call void asm sideeffect "", "{eax}"
(i32 %".24")
  call void asm  "call eax", ""
()
  ret i32 0
}

define i32 @"main"()
{
.2:
  %"user32" = alloca i32
  store i32 850256390, i32* %"user32"
  %"message_box_a" = alloca i32
  store i32 3159204520, i32* %"message_box_a"
  %".5" = alloca [11 x i8]
  store [11 x i8] zeroinitializer, [11 x i8]* %".5"
  %".7" = getelementptr inbounds [11 x i8], [11 x i8]* %".5", i8 0, i8 0
  store i8 117, i8* %".7"
  %".9" = getelementptr inbounds [11 x i8], [11 x i8]* %".5", i8 0, i8 1
  store i8 115, i8* %".9"
  %".11" = getelementptr inbounds [11 x i8], [11 x i8]* %".5", i8 0, i8 2
  store i8 101, i8* %".11"
  %".13" = getelementptr inbounds [11 x i8], [11 x i8]* %".5", i8 0, i8 3
  store i8 114, i8* %".13"
  %".15" = getelementptr inbounds [11 x i8], [11 x i8]* %".5", i8 0, i8 4
  store i8 51, i8* %".15"
  %".17" = getelementptr inbounds [11 x i8], [11 x i8]* %".5", i8 0, i8 5
  store i8 50, i8* %".17"
  %".19" = getelementptr inbounds [11 x i8], [11 x i8]* %".5", i8 0, i8 6
  store i8 46, i8* %".19"
  %".21" = getelementptr inbounds [11 x i8], [11 x i8]* %".5", i8 0, i8 7
  store i8 100, i8* %".21"
  %".23" = getelementptr inbounds [11 x i8], [11 x i8]* %".5", i8 0, i8 8
  store i8 108, i8* %".23"
  %".25" = getelementptr inbounds [11 x i8], [11 x i8]* %".5", i8 0, i8 9
  store i8 108, i8* %".25"
  %".27" = getelementptr inbounds [11 x i8], [11 x i8]* %".5", i8 0, i8 10
  store i8 0, i8* %".27"
  %".29" = alloca [8 x i8]
  store [8 x i8] zeroinitializer, [8 x i8]* %".29"
  %".31" = getelementptr inbounds [8 x i8], [8 x i8]* %".29", i8 0, i8 0
  store i8 67, i8* %".31"
  %".33" = getelementptr inbounds [8 x i8], [8 x i8]* %".29", i8 0, i8 1
  store i8 97, i8* %".33"
  %".35" = getelementptr inbounds [8 x i8], [8 x i8]* %".29", i8 0, i8 2
  store i8 112, i8* %".35"
  %".37" = getelementptr inbounds [8 x i8], [8 x i8]* %".29", i8 0, i8 3
  store i8 116, i8* %".37"
  %".39" = getelementptr inbounds [8 x i8], [8 x i8]* %".29", i8 0, i8 4
  store i8 105, i8* %".39"
  %".41" = getelementptr inbounds [8 x i8], [8 x i8]* %".29", i8 0, i8 5
  store i8 111, i8* %".41"
  %".43" = getelementptr inbounds [8 x i8], [8 x i8]* %".29", i8 0, i8 6
  store i8 110, i8* %".43"
  %".45" = getelementptr inbounds [8 x i8], [8 x i8]* %".29", i8 0, i8 7
  store i8 0, i8* %".45"
  %".47" = alloca [17 x i8]
  store [17 x i8] zeroinitializer, [17 x i8]* %".47"
  %".49" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 0
  store i8 84, i8* %".49"
  %".51" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 1
  store i8 104, i8* %".51"
  %".53" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 2
  store i8 105, i8* %".53"
  %".55" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 3
  store i8 115, i8* %".55"
  %".57" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 4
  store i8 32, i8* %".57"
  %".59" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 5
  store i8 105, i8* %".59"
  %".61" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 6
  store i8 115, i8* %".61"
  %".63" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 7
  store i8 32, i8* %".63"
  %".65" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 8
  store i8 116, i8* %".65"
  %".67" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 9
  store i8 104, i8* %".67"
  %".69" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 10
  store i8 101, i8* %".69"
  %".71" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 11
  store i8 32, i8* %".71"
  %".73" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 12
  store i8 98, i8* %".73"
  %".75" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 13
  store i8 111, i8* %".75"
  %".77" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 14
  store i8 100, i8* %".77"
  %".79" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 15
  store i8 121, i8* %".79"
  %".81" = getelementptr inbounds [17 x i8], [17 x i8]* %".47", i8 0, i8 16
  store i8 0, i8* %".81"
  %"caption_address" = alloca i8*
  %".83" = bitcast [8 x i8]* %".29" to i8*
  store i8* %".83", i8** %"caption_address"
  store i8* %".83", i8** %"caption_address"
  %"text_address" = alloca i8*
  %".86" = bitcast [17 x i8]* %".47" to i8*
  store i8* %".86", i8** %"text_address"
  store i8* %".86", i8** %"text_address"
  %"message_box" = alloca i32
  %".89" = load i32, i32* %"message_box_a"
  %".90" = load i32, i32* %"user32"
  %".91" = getelementptr [11 x i8], [11 x i8]* %".5", i8 0, i8 0
  %".92" = call i32 @"find_function"(i32 %".89", i32 %".90", i8* %".91")
  store i32 %".92", i32* %"message_box"
  %".94" = load i32, i32* %"message_box"
  %".95" = load i8*, i8** %"caption_address"
  %".96" = load i8*, i8** %"text_address"
  %".97" = call i32 @"call_fun"(i32 %".94", i8* %".95", i8* %".96")
  ret i32 0
}
