; ModuleID = 'buzz_lb_kern.c'
source_filename = "buzz_lb_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [20 x i32]*, i32*, i64*, [128 x i32]* }
%struct.anon.4 = type { [20 x i32]*, i32*, i64*, [128 x i32]* }
%struct.anon.5 = type { [2 x i32]*, i32*, i32*, [1 x i32]* }
%struct.anon.6 = type { [2 x i32]*, i32*, i32*, [1 x i32]* }
%struct.sk_reuseport_md = type { %union.anon, %union.anon.0, i32, i32, i32, i32, i32, %union.anon.1, %union.anon.2 }
%union.anon = type { i8* }
%union.anon.0 = type { i8* }
%union.anon.1 = type { %struct.bpf_sock* }
%struct.bpf_sock = type { i32, i32, i32, i32, i32, i32, i32, [4 x i32], i32, i16, i32, [4 x i32], i32, i32 }
%union.anon.2 = type { %struct.bpf_sock* }
%struct.iphdr = type { i8, i8, i16, i16, i16, i8, i8, i16, i32, i32 }
%struct.ipv6hdr = type { i8, [3 x i8], i16, i8, i8, %struct.in6_addr, %struct.in6_addr }
%struct.in6_addr = type { %union.anon.3 }
%union.anon.3 = type { [4 x i32] }

@zero = dso_local constant i32 0, align 4, !dbg !0
@balancer_max = dso_local constant i32 128, align 4, !dbg !31
@tcp_balancing_targets = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !64
@udp_balancing_targets = dso_local global %struct.anon.4 zeroinitializer, section ".maps", align 8, !dbg !84
@size = dso_local global %struct.anon.5 zeroinitializer, section ".maps", align 8, !dbg !56
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !34
@nonce = dso_local global %struct.anon.6 zeroinitializer, section ".maps", align 8, !dbg !38
@"llvm.sk_reuseport_md:0:20$0:3" = external global i64, !llvm.preserve.access.index !123 #0
@"llvm.iphdr:0:12$0:9" = external global i64, !llvm.preserve.access.index !166 #0
@"llvm.ipv6hdr:0:20$0:6:0:2:3" = external global i64, !llvm.preserve.access.index !182 #0
@"llvm.ipv6hdr:0:8$0:6:0:2:0" = external global i64, !llvm.preserve.access.index !182 #0
@"llvm.ipv6hdr:0:12$0:6:0:2:1" = external global i64, !llvm.preserve.access.index !182 #0
@"llvm.ipv6hdr:0:16$0:6:0:2:2" = external global i64, !llvm.preserve.access.index !182 #0
@"llvm.sk_reuseport_md:0:24$0:4" = external global i64, !llvm.preserve.access.index !123 #0
@llvm.compiler.used = appending global [6 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.sk_reuseport_md*)* @_selector to i8*), i8* bitcast (%struct.anon.6* @nonce to i8*), i8* bitcast (%struct.anon.5* @size to i8*), i8* bitcast (%struct.anon* @tcp_balancing_targets to i8*), i8* bitcast (%struct.anon.4* @udp_balancing_targets to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @_selector(%struct.sk_reuseport_md* noundef %0) #1 section "sk_reuseport/selector" !dbg !214 {
  %2 = alloca %struct.iphdr, align 4
  %3 = alloca %struct.ipv6hdr, align 4
  %4 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.sk_reuseport_md* %0, metadata !218, metadata !DIExpression()), !dbg !227
  %5 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %2, i64 0, i32 0, !dbg !228
  call void @llvm.lifetime.start.p0i8(i64 20, i8* nonnull %5) #7, !dbg !228
  call void @llvm.dbg.declare(metadata %struct.iphdr* %2, metadata !220, metadata !DIExpression()), !dbg !229
  %6 = getelementptr inbounds %struct.ipv6hdr, %struct.ipv6hdr* %3, i64 0, i32 0, !dbg !230
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %6) #7, !dbg !230
  call void @llvm.dbg.declare(metadata %struct.ipv6hdr* %3, metadata !221, metadata !DIExpression()), !dbg !231
  %7 = bitcast i32* %4 to i8*, !dbg !232
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %7) #7, !dbg !232
  %8 = load i64, i64* @"llvm.sk_reuseport_md:0:20$0:3", align 8
  %9 = bitcast %struct.sk_reuseport_md* %0 to i8*
  %10 = getelementptr i8, i8* %9, i64 %8
  %11 = bitcast i8* %10 to i32*
  %12 = tail call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 0, i32* %11)
  %13 = load i32, i32* %12, align 4, !dbg !233, !tbaa !234
  %14 = icmp eq i32 %13, 8, !dbg !239
  call void @llvm.dbg.value(metadata i1 %14, metadata !223, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !227
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 4 dereferenceable(40) %6, i8 0, i64 40, i1 false), !dbg !240
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 4 dereferenceable(20) %5, i8 0, i64 20, i1 false), !dbg !241
  %15 = load i64, i64* @"llvm.sk_reuseport_md:0:24$0:4", align 8
  %16 = getelementptr i8, i8* %9, i64 %15
  %17 = bitcast i8* %16 to i32*
  %18 = tail call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 6, i32* %17)
  %19 = load i32, i32* %18, align 8, !dbg !242, !tbaa !243
  switch i32 %19, label %144 [
    i32 6, label %21
    i32 17, label %20
  ], !dbg !244

20:                                               ; preds = %1
  call void @llvm.dbg.value(metadata i8* bitcast (%struct.anon.4* @udp_balancing_targets to i8*), metadata !224, metadata !DIExpression()), !dbg !227
  br label %21, !dbg !245

21:                                               ; preds = %1, %20
  %22 = phi i8* [ bitcast (%struct.anon.4* @udp_balancing_targets to i8*), %20 ], [ bitcast (%struct.anon* @tcp_balancing_targets to i8*), %1 ], !dbg !247
  call void @llvm.dbg.value(metadata i8* %22, metadata !224, metadata !DIExpression()), !dbg !227
  br i1 %14, label %23, label %25, !dbg !248

23:                                               ; preds = %21
  %24 = call i64 inttoptr (i64 68 to i64 (i8*, i32, i8*, i32, i32)*)(i8* noundef %9, i32 noundef 0, i8* noundef nonnull %5, i32 noundef 20, i32 noundef 1) #7, !dbg !249
  br label %27, !dbg !252

25:                                               ; preds = %21
  %26 = call i64 inttoptr (i64 68 to i64 (i8*, i32, i8*, i32, i32)*)(i8* noundef %9, i32 noundef 0, i8* noundef nonnull %6, i32 noundef 40, i32 noundef 1) #7, !dbg !253
  br label %27

27:                                               ; preds = %25, %23
  %28 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @size to i8*), i8* noundef bitcast (i32* @zero to i8*)) #7, !dbg !255
  %29 = bitcast i8* %28 to i32*, !dbg !255
  call void @llvm.dbg.value(metadata i32* %29, metadata !225, metadata !DIExpression()), !dbg !227
  %30 = icmp eq i8* %28, null, !dbg !256
  br i1 %30, label %34, label %31, !dbg !258

31:                                               ; preds = %27
  %32 = load i32, i32* %29, align 4, !dbg !259, !tbaa !260
  %33 = icmp eq i32 %32, 0, !dbg !261
  br i1 %33, label %34, label %36, !dbg !262

34:                                               ; preds = %31, %27
  call void @llvm.dbg.value(metadata i32* @balancer_max, metadata !225, metadata !DIExpression()), !dbg !227
  %35 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* noundef bitcast (%struct.anon.5* @size to i8*), i8* noundef bitcast (i32* @zero to i8*), i8* noundef bitcast (i32* @balancer_max to i8*), i64 noundef 0) #7, !dbg !263
  br label %36, !dbg !265

36:                                               ; preds = %34, %31
  %37 = phi i32* [ @balancer_max, %34 ], [ %29, %31 ], !dbg !227
  call void @llvm.dbg.value(metadata i32* %37, metadata !225, metadata !DIExpression()), !dbg !227
  br i1 %14, label %38, label %77, !dbg !266

38:                                               ; preds = %36
  %39 = load i64, i64* @"llvm.iphdr:0:12$0:9", align 8
  %40 = getelementptr i8, i8* %5, i64 %39
  %41 = bitcast i8* %40 to i32*
  %42 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 1, i32* %41)
  %43 = load i32, i32* %42, align 4, !dbg !267, !tbaa !270
  %44 = call i32 @llvm.bswap.i32(i32 %43), !dbg !273
  call void @llvm.dbg.value(metadata i32 %44, metadata !274, metadata !DIExpression()) #7, !dbg !287
  call void @llvm.dbg.value(metadata i32 0, metadata !279, metadata !DIExpression()) #7, !dbg !287
  call void @llvm.dbg.value(metadata i32 0, metadata !280, metadata !DIExpression()) #7, !dbg !287
  call void @llvm.dbg.value(metadata i32 0, metadata !281, metadata !DIExpression()) #7, !dbg !287
  %45 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.6* @nonce to i8*), i8* noundef bitcast (i32* @zero to i8*)) #7, !dbg !289
  %46 = bitcast i8* %45 to i32*, !dbg !289
  call void @llvm.dbg.value(metadata i32* %46, metadata !286, metadata !DIExpression()) #7, !dbg !287
  %47 = icmp eq i8* %45, null, !dbg !290
  br i1 %47, label %137, label %48, !dbg !292

48:                                               ; preds = %38
  %49 = load i32, i32* %46, align 4, !dbg !293, !tbaa !260
  %50 = icmp eq i32 %49, 0, !dbg !295
  br i1 %50, label %51, label %53, !dbg !296

51:                                               ; preds = %48
  %52 = call i32 inttoptr (i64 7 to i32 ()*)() #7, !dbg !297
  store i32 %52, i32* %46, align 4, !dbg !299, !tbaa !260
  br label %53, !dbg !300

53:                                               ; preds = %51, %48
  %54 = phi i32 [ %52, %51 ], [ %49, %48 ], !dbg !301
  call void @llvm.dbg.value(metadata i32 %54, metadata !285, metadata !DIExpression()) #7, !dbg !287
  %55 = add i32 %54, -559038725, !dbg !302
  call void @llvm.dbg.value(metadata i32 %55, metadata !285, metadata !DIExpression()) #7, !dbg !287
  %56 = add i32 %55, %44, !dbg !303
  call void @llvm.dbg.value(metadata i32 %56, metadata !282, metadata !DIExpression()) #7, !dbg !287
  call void @llvm.dbg.value(metadata i32 %55, metadata !283, metadata !DIExpression()) #7, !dbg !287
  call void @llvm.dbg.value(metadata i32 %55, metadata !284, metadata !DIExpression()) #7, !dbg !287
  call void @llvm.dbg.value(metadata i32 0, metadata !284, metadata !DIExpression()) #7, !dbg !287
  call void @llvm.dbg.value(metadata i32 %55, metadata !304, metadata !DIExpression()) #7, !dbg !310
  call void @llvm.dbg.value(metadata i32 14, metadata !309, metadata !DIExpression()) #7, !dbg !310
  %57 = call i32 @llvm.fshl.i32(i32 %55, i32 %55, i32 14) #7, !dbg !313
  %58 = sub i32 0, %57, !dbg !314
  call void @llvm.dbg.value(metadata i32 %58, metadata !284, metadata !DIExpression()) #7, !dbg !287
  %59 = xor i32 %56, %58, !dbg !314
  call void @llvm.dbg.value(metadata i32 %59, metadata !282, metadata !DIExpression()) #7, !dbg !287
  call void @llvm.dbg.value(metadata i32 %58, metadata !304, metadata !DIExpression()) #7, !dbg !315
  call void @llvm.dbg.value(metadata i32 11, metadata !309, metadata !DIExpression()) #7, !dbg !315
  %60 = call i32 @llvm.fshl.i32(i32 %58, i32 %58, i32 11) #7, !dbg !317
  %61 = sub i32 %59, %60, !dbg !314
  call void @llvm.dbg.value(metadata i32 %61, metadata !282, metadata !DIExpression()) #7, !dbg !287
  %62 = xor i32 %61, %55, !dbg !314
  call void @llvm.dbg.value(metadata i32 %62, metadata !283, metadata !DIExpression()) #7, !dbg !287
  call void @llvm.dbg.value(metadata i32 %61, metadata !304, metadata !DIExpression()) #7, !dbg !318
  call void @llvm.dbg.value(metadata i32 25, metadata !309, metadata !DIExpression()) #7, !dbg !318
  %63 = call i32 @llvm.fshl.i32(i32 %61, i32 %61, i32 25) #7, !dbg !320
  %64 = sub i32 %62, %63, !dbg !314
  call void @llvm.dbg.value(metadata i32 %64, metadata !283, metadata !DIExpression()) #7, !dbg !287
  %65 = xor i32 %64, %58, !dbg !314
  call void @llvm.dbg.value(metadata i32 %65, metadata !284, metadata !DIExpression()) #7, !dbg !287
  call void @llvm.dbg.value(metadata i32 %64, metadata !304, metadata !DIExpression()) #7, !dbg !321
  call void @llvm.dbg.value(metadata i32 16, metadata !309, metadata !DIExpression()) #7, !dbg !321
  %66 = call i32 @llvm.fshl.i32(i32 %64, i32 %64, i32 16) #7, !dbg !323
  %67 = sub i32 %65, %66, !dbg !314
  call void @llvm.dbg.value(metadata i32 %67, metadata !284, metadata !DIExpression()) #7, !dbg !287
  %68 = xor i32 %67, %61, !dbg !314
  call void @llvm.dbg.value(metadata i32 %68, metadata !282, metadata !DIExpression()) #7, !dbg !287
  call void @llvm.dbg.value(metadata i32 %67, metadata !304, metadata !DIExpression()) #7, !dbg !324
  call void @llvm.dbg.value(metadata i32 4, metadata !309, metadata !DIExpression()) #7, !dbg !324
  %69 = call i32 @llvm.fshl.i32(i32 %67, i32 %67, i32 4) #7, !dbg !326
  %70 = sub i32 %68, %69, !dbg !314
  call void @llvm.dbg.value(metadata i32 %70, metadata !282, metadata !DIExpression()) #7, !dbg !287
  %71 = xor i32 %70, %64, !dbg !314
  call void @llvm.dbg.value(metadata i32 %71, metadata !283, metadata !DIExpression()) #7, !dbg !287
  call void @llvm.dbg.value(metadata i32 %70, metadata !304, metadata !DIExpression()) #7, !dbg !327
  call void @llvm.dbg.value(metadata i32 14, metadata !309, metadata !DIExpression()) #7, !dbg !327
  %72 = call i32 @llvm.fshl.i32(i32 %70, i32 %70, i32 14) #7, !dbg !329
  %73 = sub i32 %71, %72, !dbg !314
  call void @llvm.dbg.value(metadata i32 %73, metadata !283, metadata !DIExpression()) #7, !dbg !287
  %74 = xor i32 %73, %67, !dbg !314
  call void @llvm.dbg.value(metadata i32 %74, metadata !284, metadata !DIExpression()) #7, !dbg !287
  call void @llvm.dbg.value(metadata i32 %73, metadata !304, metadata !DIExpression()) #7, !dbg !330
  call void @llvm.dbg.value(metadata i32 24, metadata !309, metadata !DIExpression()) #7, !dbg !330
  %75 = call i32 @llvm.fshl.i32(i32 %73, i32 %73, i32 24) #7, !dbg !332
  %76 = sub i32 %74, %75, !dbg !314
  call void @llvm.dbg.value(metadata i32 %76, metadata !284, metadata !DIExpression()) #7, !dbg !287
  br label %137, !dbg !333

77:                                               ; preds = %36
  %78 = load i64, i64* @"llvm.ipv6hdr:0:8$0:6:0:2:0", align 8
  %79 = getelementptr i8, i8* %6, i64 %78
  %80 = bitcast i8* %79 to i32*
  %81 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 3, i32* %80)
  %82 = load i32, i32* %81, align 4, !dbg !334, !tbaa !336
  %83 = call i32 @llvm.bswap.i32(i32 %82), !dbg !337
  %84 = load i64, i64* @"llvm.ipv6hdr:0:12$0:6:0:2:1", align 8
  %85 = getelementptr i8, i8* %6, i64 %84
  %86 = bitcast i8* %85 to i32*
  %87 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 4, i32* %86)
  %88 = load i32, i32* %87, align 4, !dbg !338, !tbaa !336
  %89 = call i32 @llvm.bswap.i32(i32 %88), !dbg !339
  %90 = load i64, i64* @"llvm.ipv6hdr:0:16$0:6:0:2:2", align 8
  %91 = getelementptr i8, i8* %6, i64 %90
  %92 = bitcast i8* %91 to i32*
  %93 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 5, i32* %92)
  %94 = load i32, i32* %93, align 4, !dbg !340, !tbaa !336
  %95 = call i32 @llvm.bswap.i32(i32 %94), !dbg !341
  %96 = load i64, i64* @"llvm.ipv6hdr:0:20$0:6:0:2:3", align 8
  %97 = getelementptr i8, i8* %6, i64 %96
  %98 = bitcast i8* %97 to i32*
  %99 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 2, i32* %98)
  %100 = load i32, i32* %99, align 4, !dbg !342, !tbaa !336
  %101 = call i32 @llvm.bswap.i32(i32 %100), !dbg !343
  call void @llvm.dbg.value(metadata i32 %83, metadata !274, metadata !DIExpression()) #7, !dbg !344
  call void @llvm.dbg.value(metadata i32 %89, metadata !279, metadata !DIExpression()) #7, !dbg !344
  call void @llvm.dbg.value(metadata i32 %95, metadata !280, metadata !DIExpression()) #7, !dbg !344
  call void @llvm.dbg.value(metadata i32 %101, metadata !281, metadata !DIExpression()) #7, !dbg !344
  %102 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.6* @nonce to i8*), i8* noundef bitcast (i32* @zero to i8*)) #7, !dbg !346
  %103 = bitcast i8* %102 to i32*, !dbg !346
  call void @llvm.dbg.value(metadata i32* %103, metadata !286, metadata !DIExpression()) #7, !dbg !344
  %104 = icmp eq i8* %102, null, !dbg !347
  br i1 %104, label %137, label %105, !dbg !348

105:                                              ; preds = %77
  %106 = load i32, i32* %103, align 4, !dbg !349, !tbaa !260
  %107 = icmp eq i32 %106, 0, !dbg !350
  br i1 %107, label %108, label %110, !dbg !351

108:                                              ; preds = %105
  %109 = call i32 inttoptr (i64 7 to i32 ()*)() #7, !dbg !352
  store i32 %109, i32* %103, align 4, !dbg !353, !tbaa !260
  br label %110, !dbg !354

110:                                              ; preds = %108, %105
  %111 = phi i32 [ %109, %108 ], [ %106, %105 ], !dbg !355
  call void @llvm.dbg.value(metadata i32 %111, metadata !285, metadata !DIExpression()) #7, !dbg !344
  %112 = add i32 %111, -559038725, !dbg !356
  call void @llvm.dbg.value(metadata i32 %112, metadata !285, metadata !DIExpression()) #7, !dbg !344
  %113 = add i32 %89, %83, !dbg !357
  %114 = add i32 %113, %95, !dbg !358
  %115 = add i32 %114, %101, !dbg !359
  %116 = add i32 %115, %112, !dbg !360
  call void @llvm.dbg.value(metadata i32 %116, metadata !282, metadata !DIExpression()) #7, !dbg !344
  call void @llvm.dbg.value(metadata i32 %112, metadata !283, metadata !DIExpression()) #7, !dbg !344
  call void @llvm.dbg.value(metadata i32 %112, metadata !284, metadata !DIExpression()) #7, !dbg !344
  call void @llvm.dbg.value(metadata i32 0, metadata !284, metadata !DIExpression()) #7, !dbg !344
  call void @llvm.dbg.value(metadata i32 %112, metadata !304, metadata !DIExpression()) #7, !dbg !361
  call void @llvm.dbg.value(metadata i32 14, metadata !309, metadata !DIExpression()) #7, !dbg !361
  %117 = call i32 @llvm.fshl.i32(i32 %112, i32 %112, i32 14) #7, !dbg !363
  %118 = sub i32 0, %117, !dbg !364
  call void @llvm.dbg.value(metadata i32 %118, metadata !284, metadata !DIExpression()) #7, !dbg !344
  %119 = xor i32 %116, %118, !dbg !364
  call void @llvm.dbg.value(metadata i32 %119, metadata !282, metadata !DIExpression()) #7, !dbg !344
  call void @llvm.dbg.value(metadata i32 %118, metadata !304, metadata !DIExpression()) #7, !dbg !365
  call void @llvm.dbg.value(metadata i32 11, metadata !309, metadata !DIExpression()) #7, !dbg !365
  %120 = call i32 @llvm.fshl.i32(i32 %118, i32 %118, i32 11) #7, !dbg !367
  %121 = sub i32 %119, %120, !dbg !364
  call void @llvm.dbg.value(metadata i32 %121, metadata !282, metadata !DIExpression()) #7, !dbg !344
  %122 = xor i32 %121, %112, !dbg !364
  call void @llvm.dbg.value(metadata i32 %122, metadata !283, metadata !DIExpression()) #7, !dbg !344
  call void @llvm.dbg.value(metadata i32 %121, metadata !304, metadata !DIExpression()) #7, !dbg !368
  call void @llvm.dbg.value(metadata i32 25, metadata !309, metadata !DIExpression()) #7, !dbg !368
  %123 = call i32 @llvm.fshl.i32(i32 %121, i32 %121, i32 25) #7, !dbg !370
  %124 = sub i32 %122, %123, !dbg !364
  call void @llvm.dbg.value(metadata i32 %124, metadata !283, metadata !DIExpression()) #7, !dbg !344
  %125 = xor i32 %124, %118, !dbg !364
  call void @llvm.dbg.value(metadata i32 %125, metadata !284, metadata !DIExpression()) #7, !dbg !344
  call void @llvm.dbg.value(metadata i32 %124, metadata !304, metadata !DIExpression()) #7, !dbg !371
  call void @llvm.dbg.value(metadata i32 16, metadata !309, metadata !DIExpression()) #7, !dbg !371
  %126 = call i32 @llvm.fshl.i32(i32 %124, i32 %124, i32 16) #7, !dbg !373
  %127 = sub i32 %125, %126, !dbg !364
  call void @llvm.dbg.value(metadata i32 %127, metadata !284, metadata !DIExpression()) #7, !dbg !344
  %128 = xor i32 %127, %121, !dbg !364
  call void @llvm.dbg.value(metadata i32 %128, metadata !282, metadata !DIExpression()) #7, !dbg !344
  call void @llvm.dbg.value(metadata i32 %127, metadata !304, metadata !DIExpression()) #7, !dbg !374
  call void @llvm.dbg.value(metadata i32 4, metadata !309, metadata !DIExpression()) #7, !dbg !374
  %129 = call i32 @llvm.fshl.i32(i32 %127, i32 %127, i32 4) #7, !dbg !376
  %130 = sub i32 %128, %129, !dbg !364
  call void @llvm.dbg.value(metadata i32 %130, metadata !282, metadata !DIExpression()) #7, !dbg !344
  %131 = xor i32 %130, %124, !dbg !364
  call void @llvm.dbg.value(metadata i32 %131, metadata !283, metadata !DIExpression()) #7, !dbg !344
  call void @llvm.dbg.value(metadata i32 %130, metadata !304, metadata !DIExpression()) #7, !dbg !377
  call void @llvm.dbg.value(metadata i32 14, metadata !309, metadata !DIExpression()) #7, !dbg !377
  %132 = call i32 @llvm.fshl.i32(i32 %130, i32 %130, i32 14) #7, !dbg !379
  %133 = sub i32 %131, %132, !dbg !364
  call void @llvm.dbg.value(metadata i32 %133, metadata !283, metadata !DIExpression()) #7, !dbg !344
  %134 = xor i32 %133, %127, !dbg !364
  call void @llvm.dbg.value(metadata i32 %134, metadata !284, metadata !DIExpression()) #7, !dbg !344
  call void @llvm.dbg.value(metadata i32 %133, metadata !304, metadata !DIExpression()) #7, !dbg !380
  call void @llvm.dbg.value(metadata i32 24, metadata !309, metadata !DIExpression()) #7, !dbg !380
  %135 = call i32 @llvm.fshl.i32(i32 %133, i32 %133, i32 24) #7, !dbg !382
  %136 = sub i32 %134, %135, !dbg !364
  call void @llvm.dbg.value(metadata i32 %136, metadata !284, metadata !DIExpression()) #7, !dbg !344
  br label %137, !dbg !383

137:                                              ; preds = %110, %77, %53, %38
  %138 = phi i32 [ %76, %53 ], [ 0, %38 ], [ %136, %110 ], [ 0, %77 ]
  %139 = load i32, i32* %37, align 4, !dbg !384, !tbaa !260
  %140 = urem i32 %138, %139, !dbg !384
  store i32 %140, i32* %4, align 4, !dbg !384, !tbaa !260
  call void @llvm.dbg.value(metadata i32* %4, metadata !222, metadata !DIExpression(DW_OP_deref)), !dbg !227
  %141 = call i64 inttoptr (i64 82 to i64 (%struct.sk_reuseport_md*, i8*, i8*, i64)*)(%struct.sk_reuseport_md* noundef %0, i8* noundef %22, i8* noundef nonnull %7, i64 noundef 0) #7, !dbg !385
  %142 = icmp eq i64 %141, 0, !dbg !387
  %143 = zext i1 %142 to i32
  call void @llvm.dbg.value(metadata i32 %143, metadata !219, metadata !DIExpression()), !dbg !227
  br label %144

144:                                              ; preds = %1, %137
  %145 = phi i32 [ %143, %137 ], [ 0, %1 ], !dbg !227
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %7) #7, !dbg !388
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %6) #7, !dbg !388
  call void @llvm.lifetime.end.p0i8(i64 20, i8* nonnull %5) #7, !dbg !388
  ret i32 %145, !dbg !388
}

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #3

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #4

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.bswap.i32(i32) #2

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #3

; Function Attrs: nofree nosync nounwind readnone
declare i32* @llvm.bpf.passthrough.p0i32.p0i32(i32, i32*) #5

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.value(metadata, metadata, metadata) #6

; Function Attrs: nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.fshl.i32(i32, i32, i32) #6

attributes #0 = { "btf_ama" }
attributes #1 = { nounwind "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" }
attributes #2 = { mustprogress nofree nosync nounwind readnone speculatable willreturn }
attributes #3 = { argmemonly mustprogress nofree nosync nounwind willreturn }
attributes #4 = { argmemonly mustprogress nofree nounwind willreturn writeonly }
attributes #5 = { nofree nosync nounwind readnone }
attributes #6 = { nofree nosync nounwind readnone speculatable willreturn }
attributes #7 = { nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!209, !210, !211, !212}
!llvm.ident = !{!213}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "zero", scope: !2, file: !3, line: 26, type: !33, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.0-1ubuntu1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !21, globals: !30, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "buzz_lb_kern.c", directory: "/media/aadhitya/DATA/XCodes/buzzLB/src", checksumkind: CSK_MD5, checksum: "0ce1b0bd390ef570fe78603adaa5b0d0")
!4 = !{!5, !11, !15}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "sk_action", file: !6, line: 43317, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "./vmlinux.h", directory: "/media/aadhitya/DATA/XCodes/buzzLB/src", checksumkind: CSK_MD5, checksum: "11eb692ee35903a9cd527ec4f7485b7b")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10}
!9 = !DIEnumerator(name: "SK_DROP", value: 0)
!10 = !DIEnumerator(name: "SK_PASS", value: 1)
!11 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "bpf_hdr_start_off", file: !6, line: 122169, baseType: !7, size: 32, elements: !12)
!12 = !{!13, !14}
!13 = !DIEnumerator(name: "BPF_HDR_START_MAC", value: 0)
!14 = !DIEnumerator(name: "BPF_HDR_START_NET", value: 1)
!15 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 43553, baseType: !7, size: 32, elements: !16)
!16 = !{!17, !18, !19, !20}
!17 = !DIEnumerator(name: "BPF_ANY", value: 0)
!18 = !DIEnumerator(name: "BPF_NOEXIST", value: 1)
!19 = !DIEnumerator(name: "BPF_EXIST", value: 2)
!20 = !DIEnumerator(name: "BPF_F_LOCK", value: 4)
!21 = !{!22, !24, !26}
!22 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !6, line: 10, baseType: !23)
!23 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!24 = !DIDerivedType(tag: DW_TAG_typedef, name: "u32", file: !6, line: 409, baseType: !25)
!25 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !6, line: 12, baseType: !7)
!26 = !DICompositeType(tag: DW_TAG_array_type, baseType: !27, size: 128, elements: !28)
!27 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !6, line: 7174, baseType: !25)
!28 = !{!29}
!29 = !DISubrange(count: 4)
!30 = !{!0, !31, !34, !38, !56, !64, !84, !92, !102, !107, !112, !117}
!31 = !DIGlobalVariableExpression(var: !32, expr: !DIExpression())
!32 = distinct !DIGlobalVariable(name: "balancer_max", scope: !2, file: !3, line: 27, type: !33, isLocal: false, isDefinition: true)
!33 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !24)
!34 = !DIGlobalVariableExpression(var: !35, expr: !DIExpression())
!35 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 187, type: !36, isLocal: false, isDefinition: true)
!36 = !DICompositeType(tag: DW_TAG_array_type, baseType: !37, size: 32, elements: !28)
!37 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!38 = !DIGlobalVariableExpression(var: !39, expr: !DIExpression())
!39 = distinct !DIGlobalVariable(name: "nonce", scope: !2, file: !3, line: 36, type: !40, isLocal: false, isDefinition: true)
!40 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 31, size: 256, elements: !41)
!41 = !{!42, !48, !50, !51}
!42 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !40, file: !3, line: 32, baseType: !43, size: 64)
!43 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !44, size: 64)
!44 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 64, elements: !46)
!45 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!46 = !{!47}
!47 = !DISubrange(count: 2)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !40, file: !3, line: 33, baseType: !49, size: 64, offset: 64)
!49 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!50 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !40, file: !3, line: 34, baseType: !49, size: 64, offset: 128)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !40, file: !3, line: 35, baseType: !52, size: 64, offset: 192)
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 32, elements: !54)
!54 = !{!55}
!55 = !DISubrange(count: 1)
!56 = !DIGlobalVariableExpression(var: !57, expr: !DIExpression())
!57 = distinct !DIGlobalVariable(name: "size", scope: !2, file: !3, line: 43, type: !58, isLocal: false, isDefinition: true)
!58 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 38, size: 256, elements: !59)
!59 = !{!60, !61, !62, !63}
!60 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !58, file: !3, line: 39, baseType: !43, size: 64)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !58, file: !3, line: 40, baseType: !49, size: 64, offset: 64)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !58, file: !3, line: 41, baseType: !49, size: 64, offset: 128)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !58, file: !3, line: 42, baseType: !52, size: 64, offset: 192)
!64 = !DIGlobalVariableExpression(var: !65, expr: !DIExpression())
!65 = distinct !DIGlobalVariable(name: "tcp_balancing_targets", scope: !2, file: !3, line: 50, type: !66, isLocal: false, isDefinition: true)
!66 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 45, size: 256, elements: !67)
!67 = !{!68, !73, !74, !79}
!68 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !66, file: !3, line: 46, baseType: !69, size: 64)
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !70, size: 64)
!70 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 640, elements: !71)
!71 = !{!72}
!72 = !DISubrange(count: 20)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !66, file: !3, line: 47, baseType: !49, size: 64, offset: 64)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !66, file: !3, line: 48, baseType: !75, size: 64, offset: 128)
!75 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !76, size: 64)
!76 = !DIDerivedType(tag: DW_TAG_typedef, name: "u64", file: !6, line: 18, baseType: !77)
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !6, line: 16, baseType: !78)
!78 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !66, file: !3, line: 49, baseType: !80, size: 64, offset: 192)
!80 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !81, size: 64)
!81 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 4096, elements: !82)
!82 = !{!83}
!83 = !DISubrange(count: 128)
!84 = !DIGlobalVariableExpression(var: !85, expr: !DIExpression())
!85 = distinct !DIGlobalVariable(name: "udp_balancing_targets", scope: !2, file: !3, line: 57, type: !86, isLocal: false, isDefinition: true)
!86 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 52, size: 256, elements: !87)
!87 = !{!88, !89, !90, !91}
!88 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !86, file: !3, line: 53, baseType: !69, size: 64)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !86, file: !3, line: 54, baseType: !49, size: 64, offset: 64)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !86, file: !3, line: 55, baseType: !75, size: 64, offset: 128)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !86, file: !3, line: 56, baseType: !80, size: 64, offset: 192)
!92 = !DIGlobalVariableExpression(var: !93, expr: !DIExpression())
!93 = distinct !DIGlobalVariable(name: "bpf_skb_load_bytes_relative", scope: !2, file: !94, line: 1813, type: !95, isLocal: true, isDefinition: true)
!94 = !DIFile(filename: "./../libbpf/src/bpf_helper_defs.h", directory: "/media/aadhitya/DATA/XCodes/buzzLB/src", checksumkind: CSK_MD5, checksum: "2d210aba22162d34a56b8d1dc5e331a2")
!95 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !96, size: 64)
!96 = !DISubroutineType(types: !97)
!97 = !{!98, !99, !25, !101, !25, !25}
!98 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!99 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !100, size: 64)
!100 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!101 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!102 = !DIGlobalVariableExpression(var: !103, expr: !DIExpression())
!103 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !94, line: 56, type: !104, isLocal: true, isDefinition: true)
!104 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !105, size: 64)
!105 = !DISubroutineType(types: !106)
!106 = !{!101, !101, !99}
!107 = !DIGlobalVariableExpression(var: !108, expr: !DIExpression())
!108 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !94, line: 78, type: !109, isLocal: true, isDefinition: true)
!109 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !110, size: 64)
!110 = !DISubroutineType(types: !111)
!111 = !{!98, !101, !99, !99, !77}
!112 = !DIGlobalVariableExpression(var: !113, expr: !DIExpression())
!113 = distinct !DIGlobalVariable(name: "bpf_get_prandom_u32", scope: !2, file: !94, line: 193, type: !114, isLocal: true, isDefinition: true)
!114 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !115, size: 64)
!115 = !DISubroutineType(types: !116)
!116 = !{!25}
!117 = !DIGlobalVariableExpression(var: !118, expr: !DIExpression())
!118 = distinct !DIGlobalVariable(name: "bpf_sk_select_reuseport", scope: !2, file: !94, line: 2148, type: !119, isLocal: true, isDefinition: true)
!119 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !120, size: 64)
!120 = !DISubroutineType(types: !121)
!121 = !{!98, !122, !101, !101, !77}
!122 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !123, size: 64)
!123 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "sk_reuseport_md", file: !6, line: 46184, size: 448, elements: !124)
!124 = !{!125, !129, !133, !134, !135, !136, !137, !138, !162}
!125 = !DIDerivedType(tag: DW_TAG_member, scope: !123, file: !6, line: 46185, baseType: !126, size: 64)
!126 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !123, file: !6, line: 46185, size: 64, elements: !127)
!127 = !{!128}
!128 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !126, file: !6, line: 46186, baseType: !101, size: 64)
!129 = !DIDerivedType(tag: DW_TAG_member, scope: !123, file: !6, line: 46188, baseType: !130, size: 64, offset: 64)
!130 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !123, file: !6, line: 46188, size: 64, elements: !131)
!131 = !{!132}
!132 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !130, file: !6, line: 46189, baseType: !101, size: 64)
!133 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !123, file: !6, line: 46191, baseType: !25, size: 32, offset: 128)
!134 = !DIDerivedType(tag: DW_TAG_member, name: "eth_protocol", scope: !123, file: !6, line: 46192, baseType: !25, size: 32, offset: 160)
!135 = !DIDerivedType(tag: DW_TAG_member, name: "ip_protocol", scope: !123, file: !6, line: 46193, baseType: !25, size: 32, offset: 192)
!136 = !DIDerivedType(tag: DW_TAG_member, name: "bind_inany", scope: !123, file: !6, line: 46194, baseType: !25, size: 32, offset: 224)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "hash", scope: !123, file: !6, line: 46195, baseType: !25, size: 32, offset: 256)
!138 = !DIDerivedType(tag: DW_TAG_member, scope: !123, file: !6, line: 46196, baseType: !139, size: 64, offset: 320)
!139 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !123, file: !6, line: 46196, size: 64, elements: !140)
!140 = !{!141}
!141 = !DIDerivedType(tag: DW_TAG_member, name: "sk", scope: !139, file: !6, line: 46197, baseType: !142, size: 64)
!142 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !143, size: 64)
!143 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_sock", file: !6, line: 46097, size: 640, elements: !144)
!144 = !{!145, !146, !147, !148, !149, !150, !151, !152, !154, !155, !157, !158, !159, !160}
!145 = !DIDerivedType(tag: DW_TAG_member, name: "bound_dev_if", scope: !143, file: !6, line: 46098, baseType: !25, size: 32)
!146 = !DIDerivedType(tag: DW_TAG_member, name: "family", scope: !143, file: !6, line: 46099, baseType: !25, size: 32, offset: 32)
!147 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !143, file: !6, line: 46100, baseType: !25, size: 32, offset: 64)
!148 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !143, file: !6, line: 46101, baseType: !25, size: 32, offset: 96)
!149 = !DIDerivedType(tag: DW_TAG_member, name: "mark", scope: !143, file: !6, line: 46102, baseType: !25, size: 32, offset: 128)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !143, file: !6, line: 46103, baseType: !25, size: 32, offset: 160)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip4", scope: !143, file: !6, line: 46104, baseType: !25, size: 32, offset: 192)
!152 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip6", scope: !143, file: !6, line: 46105, baseType: !153, size: 128, offset: 224)
!153 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 128, elements: !28)
!154 = !DIDerivedType(tag: DW_TAG_member, name: "src_port", scope: !143, file: !6, line: 46106, baseType: !25, size: 32, offset: 352)
!155 = !DIDerivedType(tag: DW_TAG_member, name: "dst_port", scope: !143, file: !6, line: 46107, baseType: !156, size: 16, offset: 384)
!156 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !6, line: 7170, baseType: !22)
!157 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip4", scope: !143, file: !6, line: 46108, baseType: !25, size: 32, offset: 416)
!158 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip6", scope: !143, file: !6, line: 46109, baseType: !153, size: 128, offset: 448)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !143, file: !6, line: 46110, baseType: !25, size: 32, offset: 576)
!160 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_mapping", scope: !143, file: !6, line: 46111, baseType: !161, size: 32, offset: 608)
!161 = !DIDerivedType(tag: DW_TAG_typedef, name: "__s32", file: !6, line: 401, baseType: !45)
!162 = !DIDerivedType(tag: DW_TAG_member, scope: !123, file: !6, line: 46199, baseType: !163, size: 64, offset: 384)
!163 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !123, file: !6, line: 46199, size: 64, elements: !164)
!164 = !{!165}
!165 = !DIDerivedType(tag: DW_TAG_member, name: "migrating_sk", scope: !163, file: !6, line: 46200, baseType: !142, size: 64)
!166 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !6, line: 66181, size: 160, elements: !167)
!167 = !{!168, !171, !172, !173, !174, !175, !176, !177, !178, !180, !181}
!168 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !166, file: !6, line: 66182, baseType: !169, size: 4, flags: DIFlagBitField, extraData: i64 0)
!169 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !6, line: 8, baseType: !170)
!170 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!171 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !166, file: !6, line: 66183, baseType: !169, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!172 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !166, file: !6, line: 66184, baseType: !169, size: 8, offset: 8)
!173 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !166, file: !6, line: 66185, baseType: !156, size: 16, offset: 16)
!174 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !166, file: !6, line: 66186, baseType: !156, size: 16, offset: 32)
!175 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !166, file: !6, line: 66187, baseType: !156, size: 16, offset: 48)
!176 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !166, file: !6, line: 66188, baseType: !169, size: 8, offset: 64)
!177 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !166, file: !6, line: 66189, baseType: !169, size: 8, offset: 72)
!178 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !166, file: !6, line: 66190, baseType: !179, size: 16, offset: 80)
!179 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !6, line: 65086, baseType: !22)
!180 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !166, file: !6, line: 66191, baseType: !27, size: 32, offset: 96)
!181 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !166, file: !6, line: 66192, baseType: !27, size: 32, offset: 128)
!182 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ipv6hdr", file: !6, line: 66207, size: 320, elements: !183)
!183 = !{!184, !185, !186, !190, !191, !192, !193, !208}
!184 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !182, file: !6, line: 66208, baseType: !169, size: 4, flags: DIFlagBitField, extraData: i64 0)
!185 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !182, file: !6, line: 66209, baseType: !169, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!186 = !DIDerivedType(tag: DW_TAG_member, name: "flow_lbl", scope: !182, file: !6, line: 66210, baseType: !187, size: 24, offset: 8)
!187 = !DICompositeType(tag: DW_TAG_array_type, baseType: !169, size: 24, elements: !188)
!188 = !{!189}
!189 = !DISubrange(count: 3)
!190 = !DIDerivedType(tag: DW_TAG_member, name: "payload_len", scope: !182, file: !6, line: 66211, baseType: !156, size: 16, offset: 32)
!191 = !DIDerivedType(tag: DW_TAG_member, name: "nexthdr", scope: !182, file: !6, line: 66212, baseType: !169, size: 8, offset: 48)
!192 = !DIDerivedType(tag: DW_TAG_member, name: "hop_limit", scope: !182, file: !6, line: 66213, baseType: !169, size: 8, offset: 56)
!193 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !182, file: !6, line: 66214, baseType: !194, size: 128, offset: 64)
!194 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "in6_addr", file: !6, line: 9641, size: 128, elements: !195)
!195 = !{!196}
!196 = !DIDerivedType(tag: DW_TAG_member, name: "in6_u", scope: !194, file: !6, line: 9646, baseType: !197, size: 128)
!197 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !194, file: !6, line: 9642, size: 128, elements: !198)
!198 = !{!199, !203, !207}
!199 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr8", scope: !197, file: !6, line: 9643, baseType: !200, size: 128)
!200 = !DICompositeType(tag: DW_TAG_array_type, baseType: !169, size: 128, elements: !201)
!201 = !{!202}
!202 = !DISubrange(count: 16)
!203 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr16", scope: !197, file: !6, line: 9644, baseType: !204, size: 128)
!204 = !DICompositeType(tag: DW_TAG_array_type, baseType: !156, size: 128, elements: !205)
!205 = !{!206}
!206 = !DISubrange(count: 8)
!207 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr32", scope: !197, file: !6, line: 9645, baseType: !26, size: 128)
!208 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !182, file: !6, line: 66215, baseType: !194, size: 128, offset: 192)
!209 = !{i32 7, !"Dwarf Version", i32 5}
!210 = !{i32 2, !"Debug Info Version", i32 3}
!211 = !{i32 1, !"wchar_size", i32 4}
!212 = !{i32 7, !"frame-pointer", i32 2}
!213 = !{!"Ubuntu clang version 14.0.0-1ubuntu1"}
!214 = distinct !DISubprogram(name: "_selector", scope: !3, file: !3, line: 107, type: !215, scopeLine: 107, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !217)
!215 = !DISubroutineType(types: !216)
!216 = !{!5, !122}
!217 = !{!218, !219, !220, !221, !222, !223, !224, !225}
!218 = !DILocalVariable(name: "reuse", arg: 1, scope: !214, file: !3, line: 107, type: !122)
!219 = !DILocalVariable(name: "action", scope: !214, file: !3, line: 108, type: !5)
!220 = !DILocalVariable(name: "ip", scope: !214, file: !3, line: 109, type: !166)
!221 = !DILocalVariable(name: "ipv6", scope: !214, file: !3, line: 110, type: !182)
!222 = !DILocalVariable(name: "key", scope: !214, file: !3, line: 112, type: !24)
!223 = !DILocalVariable(name: "is_ipv4", scope: !214, file: !3, line: 114, type: !45)
!224 = !DILocalVariable(name: "targets", scope: !214, file: !3, line: 115, type: !101)
!225 = !DILocalVariable(name: "balancer_count", scope: !214, file: !3, line: 141, type: !226)
!226 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!227 = !DILocation(line: 0, scope: !214)
!228 = !DILocation(line: 109, column: 3, scope: !214)
!229 = !DILocation(line: 109, column: 16, scope: !214)
!230 = !DILocation(line: 110, column: 3, scope: !214)
!231 = !DILocation(line: 110, column: 18, scope: !214)
!232 = !DILocation(line: 112, column: 3, scope: !214)
!233 = !DILocation(line: 114, column: 24, scope: !214)
!234 = !{!235, !238, i64 20}
!235 = !{!"sk_reuseport_md", !236, i64 0, !236, i64 8, !238, i64 16, !238, i64 20, !238, i64 24, !238, i64 28, !238, i64 32, !236, i64 40, !236, i64 48}
!236 = !{!"omnipotent char", !237, i64 0}
!237 = !{!"Simple C/C++ TBAA"}
!238 = !{!"int", !236, i64 0}
!239 = !DILocation(line: 114, column: 37, scope: !214)
!240 = !DILocation(line: 118, column: 3, scope: !214)
!241 = !DILocation(line: 119, column: 3, scope: !214)
!242 = !DILocation(line: 121, column: 18, scope: !214)
!243 = !{!235, !238, i64 24}
!244 = !DILocation(line: 121, column: 3, scope: !214)
!245 = !DILocation(line: 127, column: 7, scope: !246)
!246 = distinct !DILexicalBlock(scope: !214, file: !3, line: 121, column: 31)
!247 = !DILocation(line: 0, scope: !246)
!248 = !DILocation(line: 135, column: 6, scope: !214)
!249 = !DILocation(line: 136, column: 5, scope: !250)
!250 = distinct !DILexicalBlock(scope: !251, file: !3, line: 135, column: 14)
!251 = distinct !DILexicalBlock(scope: !214, file: !3, line: 135, column: 6)
!252 = !DILocation(line: 137, column: 3, scope: !250)
!253 = !DILocation(line: 138, column: 5, scope: !254)
!254 = distinct !DILexicalBlock(scope: !251, file: !3, line: 137, column: 10)
!255 = !DILocation(line: 141, column: 31, scope: !214)
!256 = !DILocation(line: 142, column: 8, scope: !257)
!257 = distinct !DILexicalBlock(scope: !214, file: !3, line: 142, column: 7)
!258 = !DILocation(line: 142, column: 23, scope: !257)
!259 = !DILocation(line: 142, column: 26, scope: !257)
!260 = !{!238, !238, i64 0}
!261 = !DILocation(line: 142, column: 42, scope: !257)
!262 = !DILocation(line: 142, column: 7, scope: !214)
!263 = !DILocation(line: 144, column: 5, scope: !264)
!264 = distinct !DILexicalBlock(scope: !257, file: !3, line: 142, column: 48)
!265 = !DILocation(line: 145, column: 3, scope: !264)
!266 = !DILocation(line: 152, column: 6, scope: !214)
!267 = !DILocation(line: 153, column: 37, scope: !268)
!268 = distinct !DILexicalBlock(scope: !269, file: !3, line: 152, column: 14)
!269 = distinct !DILexicalBlock(scope: !214, file: !3, line: 152, column: 6)
!270 = !{!271, !238, i64 12}
!271 = !{!"iphdr", !236, i64 0, !236, i64 0, !236, i64 1, !272, i64 2, !272, i64 4, !272, i64 6, !236, i64 8, !236, i64 9, !272, i64 10, !238, i64 12, !238, i64 16}
!272 = !{!"short", !236, i64 0}
!273 = !DILocation(line: 153, column: 16, scope: !268)
!274 = !DILocalVariable(name: "ip_p1", arg: 1, scope: !275, file: !3, line: 76, type: !24)
!275 = distinct !DISubprogram(name: "hash", scope: !3, file: !3, line: 76, type: !276, scopeLine: 76, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !278)
!276 = !DISubroutineType(types: !277)
!277 = !{!24, !24, !24, !24, !24}
!278 = !{!274, !279, !280, !281, !282, !283, !284, !285, !286}
!279 = !DILocalVariable(name: "ip_p2", arg: 2, scope: !275, file: !3, line: 76, type: !24)
!280 = !DILocalVariable(name: "ip_p3", arg: 3, scope: !275, file: !3, line: 76, type: !24)
!281 = !DILocalVariable(name: "ip_p4", arg: 4, scope: !275, file: !3, line: 76, type: !24)
!282 = !DILocalVariable(name: "a", scope: !275, file: !3, line: 77, type: !24)
!283 = !DILocalVariable(name: "b", scope: !275, file: !3, line: 77, type: !24)
!284 = !DILocalVariable(name: "c", scope: !275, file: !3, line: 77, type: !24)
!285 = !DILocalVariable(name: "initval", scope: !275, file: !3, line: 77, type: !24)
!286 = !DILocalVariable(name: "n", scope: !275, file: !3, line: 77, type: !49)
!287 = !DILocation(line: 0, scope: !275, inlinedAt: !288)
!288 = distinct !DILocation(line: 153, column: 11, scope: !268)
!289 = !DILocation(line: 80, column: 7, scope: !275, inlinedAt: !288)
!290 = !DILocation(line: 81, column: 9, scope: !291, inlinedAt: !288)
!291 = distinct !DILexicalBlock(scope: !275, file: !3, line: 81, column: 7)
!292 = !DILocation(line: 81, column: 7, scope: !275, inlinedAt: !288)
!293 = !DILocation(line: 86, column: 7, scope: !294, inlinedAt: !288)
!294 = distinct !DILexicalBlock(scope: !275, file: !3, line: 86, column: 7)
!295 = !DILocation(line: 86, column: 10, scope: !294, inlinedAt: !288)
!296 = !DILocation(line: 86, column: 7, scope: !275, inlinedAt: !288)
!297 = !DILocation(line: 88, column: 10, scope: !298, inlinedAt: !288)
!298 = distinct !DILexicalBlock(scope: !294, file: !3, line: 86, column: 16)
!299 = !DILocation(line: 88, column: 8, scope: !298, inlinedAt: !288)
!300 = !DILocation(line: 93, column: 3, scope: !298, inlinedAt: !288)
!301 = !DILocation(line: 95, column: 13, scope: !275, inlinedAt: !288)
!302 = !DILocation(line: 97, column: 11, scope: !275, inlinedAt: !288)
!303 = !DILocation(line: 98, column: 37, scope: !275, inlinedAt: !288)
!304 = !DILocalVariable(name: "word", arg: 1, scope: !305, file: !3, line: 74, type: !25)
!305 = distinct !DISubprogram(name: "rol32", scope: !3, file: !3, line: 74, type: !306, scopeLine: 74, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !308)
!306 = !DISubroutineType(types: !307)
!307 = !{!25, !25, !7}
!308 = !{!304, !309}
!309 = !DILocalVariable(name: "shift", arg: 2, scope: !305, file: !3, line: 74, type: !7)
!310 = !DILocation(line: 0, scope: !305, inlinedAt: !311)
!311 = distinct !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !288)
!312 = distinct !DILexicalBlock(scope: !275, file: !3, line: 102, column: 3)
!313 = !DILocation(line: 74, column: 91, scope: !305, inlinedAt: !311)
!314 = !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !288)
!315 = !DILocation(line: 0, scope: !305, inlinedAt: !316)
!316 = distinct !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !288)
!317 = !DILocation(line: 74, column: 91, scope: !305, inlinedAt: !316)
!318 = !DILocation(line: 0, scope: !305, inlinedAt: !319)
!319 = distinct !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !288)
!320 = !DILocation(line: 74, column: 91, scope: !305, inlinedAt: !319)
!321 = !DILocation(line: 0, scope: !305, inlinedAt: !322)
!322 = distinct !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !288)
!323 = !DILocation(line: 74, column: 91, scope: !305, inlinedAt: !322)
!324 = !DILocation(line: 0, scope: !305, inlinedAt: !325)
!325 = distinct !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !288)
!326 = !DILocation(line: 74, column: 91, scope: !305, inlinedAt: !325)
!327 = !DILocation(line: 0, scope: !305, inlinedAt: !328)
!328 = distinct !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !288)
!329 = !DILocation(line: 74, column: 91, scope: !305, inlinedAt: !328)
!330 = !DILocation(line: 0, scope: !305, inlinedAt: !331)
!331 = distinct !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !288)
!332 = !DILocation(line: 74, column: 91, scope: !305, inlinedAt: !331)
!333 = !DILocation(line: 103, column: 3, scope: !275, inlinedAt: !288)
!334 = !DILocation(line: 156, column: 25, scope: !335)
!335 = distinct !DILexicalBlock(scope: !269, file: !3, line: 154, column: 10)
!336 = !{!236, !236, i64 0}
!337 = !DILocation(line: 156, column: 7, scope: !335)
!338 = !DILocation(line: 157, column: 25, scope: !335)
!339 = !DILocation(line: 157, column: 7, scope: !335)
!340 = !DILocation(line: 158, column: 25, scope: !335)
!341 = !DILocation(line: 158, column: 7, scope: !335)
!342 = !DILocation(line: 159, column: 25, scope: !335)
!343 = !DILocation(line: 159, column: 7, scope: !335)
!344 = !DILocation(line: 0, scope: !275, inlinedAt: !345)
!345 = distinct !DILocation(line: 155, column: 11, scope: !335)
!346 = !DILocation(line: 80, column: 7, scope: !275, inlinedAt: !345)
!347 = !DILocation(line: 81, column: 9, scope: !291, inlinedAt: !345)
!348 = !DILocation(line: 81, column: 7, scope: !275, inlinedAt: !345)
!349 = !DILocation(line: 86, column: 7, scope: !294, inlinedAt: !345)
!350 = !DILocation(line: 86, column: 10, scope: !294, inlinedAt: !345)
!351 = !DILocation(line: 86, column: 7, scope: !275, inlinedAt: !345)
!352 = !DILocation(line: 88, column: 10, scope: !298, inlinedAt: !345)
!353 = !DILocation(line: 88, column: 8, scope: !298, inlinedAt: !345)
!354 = !DILocation(line: 93, column: 3, scope: !298, inlinedAt: !345)
!355 = !DILocation(line: 95, column: 13, scope: !275, inlinedAt: !345)
!356 = !DILocation(line: 97, column: 11, scope: !275, inlinedAt: !345)
!357 = !DILocation(line: 98, column: 13, scope: !275, inlinedAt: !345)
!358 = !DILocation(line: 98, column: 21, scope: !275, inlinedAt: !345)
!359 = !DILocation(line: 98, column: 29, scope: !275, inlinedAt: !345)
!360 = !DILocation(line: 98, column: 37, scope: !275, inlinedAt: !345)
!361 = !DILocation(line: 0, scope: !305, inlinedAt: !362)
!362 = distinct !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !345)
!363 = !DILocation(line: 74, column: 91, scope: !305, inlinedAt: !362)
!364 = !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !345)
!365 = !DILocation(line: 0, scope: !305, inlinedAt: !366)
!366 = distinct !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !345)
!367 = !DILocation(line: 74, column: 91, scope: !305, inlinedAt: !366)
!368 = !DILocation(line: 0, scope: !305, inlinedAt: !369)
!369 = distinct !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !345)
!370 = !DILocation(line: 74, column: 91, scope: !305, inlinedAt: !369)
!371 = !DILocation(line: 0, scope: !305, inlinedAt: !372)
!372 = distinct !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !345)
!373 = !DILocation(line: 74, column: 91, scope: !305, inlinedAt: !372)
!374 = !DILocation(line: 0, scope: !305, inlinedAt: !375)
!375 = distinct !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !345)
!376 = !DILocation(line: 74, column: 91, scope: !305, inlinedAt: !375)
!377 = !DILocation(line: 0, scope: !305, inlinedAt: !378)
!378 = distinct !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !345)
!379 = !DILocation(line: 74, column: 91, scope: !305, inlinedAt: !378)
!380 = !DILocation(line: 0, scope: !305, inlinedAt: !381)
!381 = distinct !DILocation(line: 102, column: 3, scope: !312, inlinedAt: !345)
!382 = !DILocation(line: 74, column: 91, scope: !305, inlinedAt: !381)
!383 = !DILocation(line: 103, column: 3, scope: !275, inlinedAt: !345)
!384 = !DILocation(line: 0, scope: !269)
!385 = !DILocation(line: 172, column: 7, scope: !386)
!386 = distinct !DILexicalBlock(scope: !214, file: !3, line: 172, column: 7)
!387 = !DILocation(line: 172, column: 56, scope: !386)
!388 = !DILocation(line: 185, column: 1, scope: !214)
