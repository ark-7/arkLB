; ModuleID = 'buzz_lb_kern.c'
source_filename = "buzz_lb_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [20 x i32]*, i32*, i64*, [128 x i32]*, [1 x i32]* }
%struct.anon.4 = type { [20 x i32]*, i32*, i64*, [128 x i32]*, [1 x i32]* }
%struct.anon.5 = type { [2 x i32]*, i32*, i32*, [1 x i32]*, [1 x i32]* }
%struct.anon.6 = type { [2 x i32]*, i32*, i32*, [1 x i32]*, [1 x i32]* }
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
@tcp_balancing_targets = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !66
@udp_balancing_targets = dso_local global %struct.anon.4 zeroinitializer, section ".maps", align 8, !dbg !87
@size = dso_local global %struct.anon.5 zeroinitializer, section ".maps", align 8, !dbg !57
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !34
@nonce = dso_local global %struct.anon.6 zeroinitializer, section ".maps", align 8, !dbg !38
@"llvm.sk_reuseport_md:0:20$0:3" = external global i64, !llvm.preserve.access.index !127 #0
@"llvm.iphdr:0:12$0:9" = external global i64, !llvm.preserve.access.index !170 #0
@"llvm.ipv6hdr:0:8$0:6:0:2:0" = external global i64, !llvm.preserve.access.index !186 #0
@"llvm.ipv6hdr:0:12$0:6:0:2:1" = external global i64, !llvm.preserve.access.index !186 #0
@"llvm.ipv6hdr:0:16$0:6:0:2:2" = external global i64, !llvm.preserve.access.index !186 #0
@"llvm.ipv6hdr:0:20$0:6:0:2:3" = external global i64, !llvm.preserve.access.index !186 #0
@"llvm.sk_reuseport_md:0:24$0:4" = external global i64, !llvm.preserve.access.index !127 #0
@llvm.compiler.used = appending global [6 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.sk_reuseport_md*)* @_selector to i8*), i8* bitcast (%struct.anon.6* @nonce to i8*), i8* bitcast (%struct.anon.5* @size to i8*), i8* bitcast (%struct.anon* @tcp_balancing_targets to i8*), i8* bitcast (%struct.anon.4* @udp_balancing_targets to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @_selector(%struct.sk_reuseport_md* noundef %0) #1 section "sk_reuseport/selector" !dbg !218 {
  %2 = alloca %struct.iphdr, align 4
  %3 = alloca %struct.ipv6hdr, align 4
  %4 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.sk_reuseport_md* %0, metadata !222, metadata !DIExpression()), !dbg !231
  %5 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %2, i64 0, i32 0, !dbg !232
  call void @llvm.lifetime.start.p0i8(i64 20, i8* nonnull %5) #7, !dbg !232
  call void @llvm.dbg.declare(metadata %struct.iphdr* %2, metadata !224, metadata !DIExpression()), !dbg !233
  %6 = getelementptr inbounds %struct.ipv6hdr, %struct.ipv6hdr* %3, i64 0, i32 0, !dbg !234
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %6) #7, !dbg !234
  call void @llvm.dbg.declare(metadata %struct.ipv6hdr* %3, metadata !225, metadata !DIExpression()), !dbg !235
  %7 = bitcast i32* %4 to i8*, !dbg !236
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %7) #7, !dbg !236
  %8 = load i64, i64* @"llvm.sk_reuseport_md:0:20$0:3", align 8
  %9 = bitcast %struct.sk_reuseport_md* %0 to i8*
  %10 = getelementptr i8, i8* %9, i64 %8
  %11 = bitcast i8* %10 to i32*
  %12 = tail call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 0, i32* %11)
  %13 = load i32, i32* %12, align 4, !dbg !237, !tbaa !238
  %14 = icmp eq i32 %13, 8, !dbg !243
  call void @llvm.dbg.value(metadata i1 %14, metadata !227, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !231
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 4 dereferenceable(40) %6, i8 0, i64 40, i1 false), !dbg !244
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 4 dereferenceable(20) %5, i8 0, i64 20, i1 false), !dbg !245
  %15 = load i64, i64* @"llvm.sk_reuseport_md:0:24$0:4", align 8
  %16 = getelementptr i8, i8* %9, i64 %15
  %17 = bitcast i8* %16 to i32*
  %18 = tail call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 6, i32* %17)
  %19 = load i32, i32* %18, align 8, !dbg !246, !tbaa !247
  switch i32 %19, label %144 [
    i32 6, label %21
    i32 17, label %20
  ], !dbg !248

20:                                               ; preds = %1
  call void @llvm.dbg.value(metadata i8* bitcast (%struct.anon.4* @udp_balancing_targets to i8*), metadata !228, metadata !DIExpression()), !dbg !231
  br label %21, !dbg !249

21:                                               ; preds = %1, %20
  %22 = phi i8* [ bitcast (%struct.anon.4* @udp_balancing_targets to i8*), %20 ], [ bitcast (%struct.anon* @tcp_balancing_targets to i8*), %1 ], !dbg !251
  call void @llvm.dbg.value(metadata i8* %22, metadata !228, metadata !DIExpression()), !dbg !231
  br i1 %14, label %23, label %25, !dbg !252

23:                                               ; preds = %21
  %24 = call i64 inttoptr (i64 68 to i64 (i8*, i32, i8*, i32, i32)*)(i8* noundef %9, i32 noundef 0, i8* noundef nonnull %5, i32 noundef 20, i32 noundef 1) #7, !dbg !253
  br label %27, !dbg !256

25:                                               ; preds = %21
  %26 = call i64 inttoptr (i64 68 to i64 (i8*, i32, i8*, i32, i32)*)(i8* noundef %9, i32 noundef 0, i8* noundef nonnull %6, i32 noundef 40, i32 noundef 1) #7, !dbg !257
  br label %27

27:                                               ; preds = %25, %23
  %28 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.5* @size to i8*), i8* noundef bitcast (i32* @zero to i8*)) #7, !dbg !259
  %29 = bitcast i8* %28 to i32*, !dbg !259
  call void @llvm.dbg.value(metadata i32* %29, metadata !229, metadata !DIExpression()), !dbg !231
  %30 = icmp eq i8* %28, null, !dbg !260
  br i1 %30, label %34, label %31, !dbg !262

31:                                               ; preds = %27
  %32 = load i32, i32* %29, align 4, !dbg !263, !tbaa !264
  %33 = icmp eq i32 %32, 0, !dbg !265
  br i1 %33, label %34, label %36, !dbg !266

34:                                               ; preds = %31, %27
  call void @llvm.dbg.value(metadata i32* @balancer_max, metadata !229, metadata !DIExpression()), !dbg !231
  %35 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* noundef bitcast (%struct.anon.5* @size to i8*), i8* noundef bitcast (i32* @zero to i8*), i8* noundef bitcast (i32* @balancer_max to i8*), i64 noundef 0) #7, !dbg !267
  br label %36, !dbg !269

36:                                               ; preds = %34, %31
  %37 = phi i32* [ @balancer_max, %34 ], [ %29, %31 ], !dbg !231
  call void @llvm.dbg.value(metadata i32* %37, metadata !229, metadata !DIExpression()), !dbg !231
  br i1 %14, label %38, label %77, !dbg !270

38:                                               ; preds = %36
  %39 = load i64, i64* @"llvm.iphdr:0:12$0:9", align 8
  %40 = getelementptr i8, i8* %5, i64 %39
  %41 = bitcast i8* %40 to i32*
  %42 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 1, i32* %41)
  %43 = load i32, i32* %42, align 4, !dbg !271, !tbaa !274
  %44 = call i32 @llvm.bswap.i32(i32 %43), !dbg !277
  call void @llvm.dbg.value(metadata i32 %44, metadata !278, metadata !DIExpression()) #7, !dbg !291
  call void @llvm.dbg.value(metadata i32 0, metadata !283, metadata !DIExpression()) #7, !dbg !291
  call void @llvm.dbg.value(metadata i32 0, metadata !284, metadata !DIExpression()) #7, !dbg !291
  call void @llvm.dbg.value(metadata i32 0, metadata !285, metadata !DIExpression()) #7, !dbg !291
  %45 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.6* @nonce to i8*), i8* noundef bitcast (i32* @zero to i8*)) #7, !dbg !293
  %46 = bitcast i8* %45 to i32*, !dbg !293
  call void @llvm.dbg.value(metadata i32* %46, metadata !290, metadata !DIExpression()) #7, !dbg !291
  %47 = icmp eq i8* %45, null, !dbg !294
  br i1 %47, label %137, label %48, !dbg !296

48:                                               ; preds = %38
  %49 = load i32, i32* %46, align 4, !dbg !297, !tbaa !264
  %50 = icmp eq i32 %49, 0, !dbg !299
  br i1 %50, label %51, label %53, !dbg !300

51:                                               ; preds = %48
  %52 = call i32 inttoptr (i64 7 to i32 ()*)() #7, !dbg !301
  store i32 %52, i32* %46, align 4, !dbg !303, !tbaa !264
  br label %53, !dbg !304

53:                                               ; preds = %51, %48
  %54 = phi i32 [ %52, %51 ], [ %49, %48 ], !dbg !305
  call void @llvm.dbg.value(metadata i32 %54, metadata !289, metadata !DIExpression()) #7, !dbg !291
  %55 = add i32 %54, -559038725, !dbg !306
  call void @llvm.dbg.value(metadata i32 %55, metadata !289, metadata !DIExpression()) #7, !dbg !291
  %56 = add i32 %55, %44, !dbg !307
  call void @llvm.dbg.value(metadata i32 %56, metadata !286, metadata !DIExpression()) #7, !dbg !291
  call void @llvm.dbg.value(metadata i32 %55, metadata !287, metadata !DIExpression()) #7, !dbg !291
  call void @llvm.dbg.value(metadata i32 %55, metadata !288, metadata !DIExpression()) #7, !dbg !291
  call void @llvm.dbg.value(metadata i32 0, metadata !288, metadata !DIExpression()) #7, !dbg !291
  call void @llvm.dbg.value(metadata i32 %55, metadata !308, metadata !DIExpression()) #7, !dbg !314
  call void @llvm.dbg.value(metadata i32 14, metadata !313, metadata !DIExpression()) #7, !dbg !314
  %57 = call i32 @llvm.fshl.i32(i32 %55, i32 %55, i32 14) #7, !dbg !317
  %58 = sub i32 0, %57, !dbg !318
  call void @llvm.dbg.value(metadata i32 %58, metadata !288, metadata !DIExpression()) #7, !dbg !291
  %59 = xor i32 %56, %58, !dbg !318
  call void @llvm.dbg.value(metadata i32 %59, metadata !286, metadata !DIExpression()) #7, !dbg !291
  call void @llvm.dbg.value(metadata i32 %58, metadata !308, metadata !DIExpression()) #7, !dbg !319
  call void @llvm.dbg.value(metadata i32 11, metadata !313, metadata !DIExpression()) #7, !dbg !319
  %60 = call i32 @llvm.fshl.i32(i32 %58, i32 %58, i32 11) #7, !dbg !321
  %61 = sub i32 %59, %60, !dbg !318
  call void @llvm.dbg.value(metadata i32 %61, metadata !286, metadata !DIExpression()) #7, !dbg !291
  %62 = xor i32 %61, %55, !dbg !318
  call void @llvm.dbg.value(metadata i32 %62, metadata !287, metadata !DIExpression()) #7, !dbg !291
  call void @llvm.dbg.value(metadata i32 %61, metadata !308, metadata !DIExpression()) #7, !dbg !322
  call void @llvm.dbg.value(metadata i32 25, metadata !313, metadata !DIExpression()) #7, !dbg !322
  %63 = call i32 @llvm.fshl.i32(i32 %61, i32 %61, i32 25) #7, !dbg !324
  %64 = sub i32 %62, %63, !dbg !318
  call void @llvm.dbg.value(metadata i32 %64, metadata !287, metadata !DIExpression()) #7, !dbg !291
  %65 = xor i32 %64, %58, !dbg !318
  call void @llvm.dbg.value(metadata i32 %65, metadata !288, metadata !DIExpression()) #7, !dbg !291
  call void @llvm.dbg.value(metadata i32 %64, metadata !308, metadata !DIExpression()) #7, !dbg !325
  call void @llvm.dbg.value(metadata i32 16, metadata !313, metadata !DIExpression()) #7, !dbg !325
  %66 = call i32 @llvm.fshl.i32(i32 %64, i32 %64, i32 16) #7, !dbg !327
  %67 = sub i32 %65, %66, !dbg !318
  call void @llvm.dbg.value(metadata i32 %67, metadata !288, metadata !DIExpression()) #7, !dbg !291
  %68 = xor i32 %67, %61, !dbg !318
  call void @llvm.dbg.value(metadata i32 %68, metadata !286, metadata !DIExpression()) #7, !dbg !291
  call void @llvm.dbg.value(metadata i32 %67, metadata !308, metadata !DIExpression()) #7, !dbg !328
  call void @llvm.dbg.value(metadata i32 4, metadata !313, metadata !DIExpression()) #7, !dbg !328
  %69 = call i32 @llvm.fshl.i32(i32 %67, i32 %67, i32 4) #7, !dbg !330
  %70 = sub i32 %68, %69, !dbg !318
  call void @llvm.dbg.value(metadata i32 %70, metadata !286, metadata !DIExpression()) #7, !dbg !291
  %71 = xor i32 %70, %64, !dbg !318
  call void @llvm.dbg.value(metadata i32 %71, metadata !287, metadata !DIExpression()) #7, !dbg !291
  call void @llvm.dbg.value(metadata i32 %70, metadata !308, metadata !DIExpression()) #7, !dbg !331
  call void @llvm.dbg.value(metadata i32 14, metadata !313, metadata !DIExpression()) #7, !dbg !331
  %72 = call i32 @llvm.fshl.i32(i32 %70, i32 %70, i32 14) #7, !dbg !333
  %73 = sub i32 %71, %72, !dbg !318
  call void @llvm.dbg.value(metadata i32 %73, metadata !287, metadata !DIExpression()) #7, !dbg !291
  %74 = xor i32 %73, %67, !dbg !318
  call void @llvm.dbg.value(metadata i32 %74, metadata !288, metadata !DIExpression()) #7, !dbg !291
  call void @llvm.dbg.value(metadata i32 %73, metadata !308, metadata !DIExpression()) #7, !dbg !334
  call void @llvm.dbg.value(metadata i32 24, metadata !313, metadata !DIExpression()) #7, !dbg !334
  %75 = call i32 @llvm.fshl.i32(i32 %73, i32 %73, i32 24) #7, !dbg !336
  %76 = sub i32 %74, %75, !dbg !318
  call void @llvm.dbg.value(metadata i32 %76, metadata !288, metadata !DIExpression()) #7, !dbg !291
  br label %137, !dbg !337

77:                                               ; preds = %36
  %78 = load i64, i64* @"llvm.ipv6hdr:0:8$0:6:0:2:0", align 8
  %79 = getelementptr i8, i8* %6, i64 %78
  %80 = bitcast i8* %79 to i32*
  %81 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 2, i32* %80)
  %82 = load i32, i32* %81, align 4, !dbg !338, !tbaa !340
  %83 = call i32 @llvm.bswap.i32(i32 %82), !dbg !341
  %84 = load i64, i64* @"llvm.ipv6hdr:0:12$0:6:0:2:1", align 8
  %85 = getelementptr i8, i8* %6, i64 %84
  %86 = bitcast i8* %85 to i32*
  %87 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 3, i32* %86)
  %88 = load i32, i32* %87, align 4, !dbg !342, !tbaa !340
  %89 = call i32 @llvm.bswap.i32(i32 %88), !dbg !343
  %90 = load i64, i64* @"llvm.ipv6hdr:0:16$0:6:0:2:2", align 8
  %91 = getelementptr i8, i8* %6, i64 %90
  %92 = bitcast i8* %91 to i32*
  %93 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 4, i32* %92)
  %94 = load i32, i32* %93, align 4, !dbg !344, !tbaa !340
  %95 = call i32 @llvm.bswap.i32(i32 %94), !dbg !345
  %96 = load i64, i64* @"llvm.ipv6hdr:0:20$0:6:0:2:3", align 8
  %97 = getelementptr i8, i8* %6, i64 %96
  %98 = bitcast i8* %97 to i32*
  %99 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 5, i32* %98)
  %100 = load i32, i32* %99, align 4, !dbg !346, !tbaa !340
  %101 = call i32 @llvm.bswap.i32(i32 %100), !dbg !347
  call void @llvm.dbg.value(metadata i32 %83, metadata !278, metadata !DIExpression()) #7, !dbg !348
  call void @llvm.dbg.value(metadata i32 %89, metadata !283, metadata !DIExpression()) #7, !dbg !348
  call void @llvm.dbg.value(metadata i32 %95, metadata !284, metadata !DIExpression()) #7, !dbg !348
  call void @llvm.dbg.value(metadata i32 %101, metadata !285, metadata !DIExpression()) #7, !dbg !348
  %102 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.6* @nonce to i8*), i8* noundef bitcast (i32* @zero to i8*)) #7, !dbg !350
  %103 = bitcast i8* %102 to i32*, !dbg !350
  call void @llvm.dbg.value(metadata i32* %103, metadata !290, metadata !DIExpression()) #7, !dbg !348
  %104 = icmp eq i8* %102, null, !dbg !351
  br i1 %104, label %137, label %105, !dbg !352

105:                                              ; preds = %77
  %106 = load i32, i32* %103, align 4, !dbg !353, !tbaa !264
  %107 = icmp eq i32 %106, 0, !dbg !354
  br i1 %107, label %108, label %110, !dbg !355

108:                                              ; preds = %105
  %109 = call i32 inttoptr (i64 7 to i32 ()*)() #7, !dbg !356
  store i32 %109, i32* %103, align 4, !dbg !357, !tbaa !264
  br label %110, !dbg !358

110:                                              ; preds = %108, %105
  %111 = phi i32 [ %109, %108 ], [ %106, %105 ], !dbg !359
  call void @llvm.dbg.value(metadata i32 %111, metadata !289, metadata !DIExpression()) #7, !dbg !348
  %112 = add i32 %111, -559038725, !dbg !360
  call void @llvm.dbg.value(metadata i32 %112, metadata !289, metadata !DIExpression()) #7, !dbg !348
  %113 = add i32 %89, %83, !dbg !361
  %114 = add i32 %113, %95, !dbg !362
  %115 = add i32 %114, %101, !dbg !363
  %116 = add i32 %115, %112, !dbg !364
  call void @llvm.dbg.value(metadata i32 %116, metadata !286, metadata !DIExpression()) #7, !dbg !348
  call void @llvm.dbg.value(metadata i32 %112, metadata !287, metadata !DIExpression()) #7, !dbg !348
  call void @llvm.dbg.value(metadata i32 %112, metadata !288, metadata !DIExpression()) #7, !dbg !348
  call void @llvm.dbg.value(metadata i32 0, metadata !288, metadata !DIExpression()) #7, !dbg !348
  call void @llvm.dbg.value(metadata i32 %112, metadata !308, metadata !DIExpression()) #7, !dbg !365
  call void @llvm.dbg.value(metadata i32 14, metadata !313, metadata !DIExpression()) #7, !dbg !365
  %117 = call i32 @llvm.fshl.i32(i32 %112, i32 %112, i32 14) #7, !dbg !367
  %118 = sub i32 0, %117, !dbg !368
  call void @llvm.dbg.value(metadata i32 %118, metadata !288, metadata !DIExpression()) #7, !dbg !348
  %119 = xor i32 %116, %118, !dbg !368
  call void @llvm.dbg.value(metadata i32 %119, metadata !286, metadata !DIExpression()) #7, !dbg !348
  call void @llvm.dbg.value(metadata i32 %118, metadata !308, metadata !DIExpression()) #7, !dbg !369
  call void @llvm.dbg.value(metadata i32 11, metadata !313, metadata !DIExpression()) #7, !dbg !369
  %120 = call i32 @llvm.fshl.i32(i32 %118, i32 %118, i32 11) #7, !dbg !371
  %121 = sub i32 %119, %120, !dbg !368
  call void @llvm.dbg.value(metadata i32 %121, metadata !286, metadata !DIExpression()) #7, !dbg !348
  %122 = xor i32 %121, %112, !dbg !368
  call void @llvm.dbg.value(metadata i32 %122, metadata !287, metadata !DIExpression()) #7, !dbg !348
  call void @llvm.dbg.value(metadata i32 %121, metadata !308, metadata !DIExpression()) #7, !dbg !372
  call void @llvm.dbg.value(metadata i32 25, metadata !313, metadata !DIExpression()) #7, !dbg !372
  %123 = call i32 @llvm.fshl.i32(i32 %121, i32 %121, i32 25) #7, !dbg !374
  %124 = sub i32 %122, %123, !dbg !368
  call void @llvm.dbg.value(metadata i32 %124, metadata !287, metadata !DIExpression()) #7, !dbg !348
  %125 = xor i32 %124, %118, !dbg !368
  call void @llvm.dbg.value(metadata i32 %125, metadata !288, metadata !DIExpression()) #7, !dbg !348
  call void @llvm.dbg.value(metadata i32 %124, metadata !308, metadata !DIExpression()) #7, !dbg !375
  call void @llvm.dbg.value(metadata i32 16, metadata !313, metadata !DIExpression()) #7, !dbg !375
  %126 = call i32 @llvm.fshl.i32(i32 %124, i32 %124, i32 16) #7, !dbg !377
  %127 = sub i32 %125, %126, !dbg !368
  call void @llvm.dbg.value(metadata i32 %127, metadata !288, metadata !DIExpression()) #7, !dbg !348
  %128 = xor i32 %127, %121, !dbg !368
  call void @llvm.dbg.value(metadata i32 %128, metadata !286, metadata !DIExpression()) #7, !dbg !348
  call void @llvm.dbg.value(metadata i32 %127, metadata !308, metadata !DIExpression()) #7, !dbg !378
  call void @llvm.dbg.value(metadata i32 4, metadata !313, metadata !DIExpression()) #7, !dbg !378
  %129 = call i32 @llvm.fshl.i32(i32 %127, i32 %127, i32 4) #7, !dbg !380
  %130 = sub i32 %128, %129, !dbg !368
  call void @llvm.dbg.value(metadata i32 %130, metadata !286, metadata !DIExpression()) #7, !dbg !348
  %131 = xor i32 %130, %124, !dbg !368
  call void @llvm.dbg.value(metadata i32 %131, metadata !287, metadata !DIExpression()) #7, !dbg !348
  call void @llvm.dbg.value(metadata i32 %130, metadata !308, metadata !DIExpression()) #7, !dbg !381
  call void @llvm.dbg.value(metadata i32 14, metadata !313, metadata !DIExpression()) #7, !dbg !381
  %132 = call i32 @llvm.fshl.i32(i32 %130, i32 %130, i32 14) #7, !dbg !383
  %133 = sub i32 %131, %132, !dbg !368
  call void @llvm.dbg.value(metadata i32 %133, metadata !287, metadata !DIExpression()) #7, !dbg !348
  %134 = xor i32 %133, %127, !dbg !368
  call void @llvm.dbg.value(metadata i32 %134, metadata !288, metadata !DIExpression()) #7, !dbg !348
  call void @llvm.dbg.value(metadata i32 %133, metadata !308, metadata !DIExpression()) #7, !dbg !384
  call void @llvm.dbg.value(metadata i32 24, metadata !313, metadata !DIExpression()) #7, !dbg !384
  %135 = call i32 @llvm.fshl.i32(i32 %133, i32 %133, i32 24) #7, !dbg !386
  %136 = sub i32 %134, %135, !dbg !368
  call void @llvm.dbg.value(metadata i32 %136, metadata !288, metadata !DIExpression()) #7, !dbg !348
  br label %137, !dbg !387

137:                                              ; preds = %110, %77, %53, %38
  %138 = phi i32 [ %76, %53 ], [ 0, %38 ], [ %136, %110 ], [ 0, %77 ]
  %139 = load i32, i32* %37, align 4, !dbg !388, !tbaa !264
  %140 = urem i32 %138, %139, !dbg !388
  store i32 %140, i32* %4, align 4, !dbg !388, !tbaa !264
  call void @llvm.dbg.value(metadata i32* %4, metadata !226, metadata !DIExpression(DW_OP_deref)), !dbg !231
  %141 = call i64 inttoptr (i64 82 to i64 (%struct.sk_reuseport_md*, i8*, i8*, i64)*)(%struct.sk_reuseport_md* noundef %0, i8* noundef %22, i8* noundef nonnull %7, i64 noundef 0) #7, !dbg !389
  %142 = icmp eq i64 %141, 0, !dbg !391
  %143 = zext i1 %142 to i32
  call void @llvm.dbg.value(metadata i32 %143, metadata !223, metadata !DIExpression()), !dbg !231
  br label %144

144:                                              ; preds = %1, %137
  %145 = phi i32 [ %143, %137 ], [ 0, %1 ], !dbg !231
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %7) #7, !dbg !392
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %6) #7, !dbg !392
  call void @llvm.lifetime.end.p0i8(i64 20, i8* nonnull %5) #7, !dbg !392
  ret i32 %145, !dbg !392
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
!llvm.module.flags = !{!213, !214, !215, !216}
!llvm.ident = !{!217}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "zero", scope: !2, file: !3, line: 20, type: !33, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.0-1ubuntu1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !21, globals: !30, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "buzz_lb_kern.c", directory: "/media/aadhitya/DATA/XCodes/buzzLB/src", checksumkind: CSK_MD5, checksum: "e2b5cbe10f4f260e39ce349e31a99d59")
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
!30 = !{!0, !31, !34, !38, !57, !66, !87, !96, !106, !111, !116, !121}
!31 = !DIGlobalVariableExpression(var: !32, expr: !DIExpression())
!32 = distinct !DIGlobalVariable(name: "balancer_max", scope: !2, file: !3, line: 21, type: !33, isLocal: false, isDefinition: true)
!33 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !24)
!34 = !DIGlobalVariableExpression(var: !35, expr: !DIExpression())
!35 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 195, type: !36, isLocal: false, isDefinition: true)
!36 = !DICompositeType(tag: DW_TAG_array_type, baseType: !37, size: 32, elements: !28)
!37 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!38 = !DIGlobalVariableExpression(var: !39, expr: !DIExpression())
!39 = distinct !DIGlobalVariable(name: "nonce", scope: !2, file: !3, line: 31, type: !40, isLocal: false, isDefinition: true)
!40 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 25, size: 320, elements: !41)
!41 = !{!42, !48, !50, !51, !56}
!42 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !40, file: !3, line: 26, baseType: !43, size: 64)
!43 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !44, size: 64)
!44 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 64, elements: !46)
!45 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!46 = !{!47}
!47 = !DISubrange(count: 2)
!48 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !40, file: !3, line: 27, baseType: !49, size: 64, offset: 64)
!49 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !24, size: 64)
!50 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !40, file: !3, line: 28, baseType: !49, size: 64, offset: 128)
!51 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !40, file: !3, line: 29, baseType: !52, size: 64, offset: 192)
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 32, elements: !54)
!54 = !{!55}
!55 = !DISubrange(count: 1)
!56 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !40, file: !3, line: 30, baseType: !52, size: 64, offset: 256)
!57 = !DIGlobalVariableExpression(var: !58, expr: !DIExpression())
!58 = distinct !DIGlobalVariable(name: "size", scope: !2, file: !3, line: 39, type: !59, isLocal: false, isDefinition: true)
!59 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 33, size: 320, elements: !60)
!60 = !{!61, !62, !63, !64, !65}
!61 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !59, file: !3, line: 34, baseType: !43, size: 64)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !59, file: !3, line: 35, baseType: !49, size: 64, offset: 64)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !59, file: !3, line: 36, baseType: !49, size: 64, offset: 128)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !59, file: !3, line: 37, baseType: !52, size: 64, offset: 192)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !59, file: !3, line: 38, baseType: !52, size: 64, offset: 256)
!66 = !DIGlobalVariableExpression(var: !67, expr: !DIExpression())
!67 = distinct !DIGlobalVariable(name: "tcp_balancing_targets", scope: !2, file: !3, line: 47, type: !68, isLocal: false, isDefinition: true)
!68 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 41, size: 320, elements: !69)
!69 = !{!70, !75, !76, !81, !86}
!70 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !68, file: !3, line: 42, baseType: !71, size: 64)
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !72, size: 64)
!72 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 640, elements: !73)
!73 = !{!74}
!74 = !DISubrange(count: 20)
!75 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !68, file: !3, line: 43, baseType: !49, size: 64, offset: 64)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !68, file: !3, line: 44, baseType: !77, size: 64, offset: 128)
!77 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !78, size: 64)
!78 = !DIDerivedType(tag: DW_TAG_typedef, name: "u64", file: !6, line: 18, baseType: !79)
!79 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !6, line: 16, baseType: !80)
!80 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !68, file: !3, line: 45, baseType: !82, size: 64, offset: 192)
!82 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !83, size: 64)
!83 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 4096, elements: !84)
!84 = !{!85}
!85 = !DISubrange(count: 128)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !68, file: !3, line: 46, baseType: !52, size: 64, offset: 256)
!87 = !DIGlobalVariableExpression(var: !88, expr: !DIExpression())
!88 = distinct !DIGlobalVariable(name: "udp_balancing_targets", scope: !2, file: !3, line: 55, type: !89, isLocal: false, isDefinition: true)
!89 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 49, size: 320, elements: !90)
!90 = !{!91, !92, !93, !94, !95}
!91 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !89, file: !3, line: 50, baseType: !71, size: 64)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !89, file: !3, line: 51, baseType: !49, size: 64, offset: 64)
!93 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !89, file: !3, line: 52, baseType: !77, size: 64, offset: 128)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !89, file: !3, line: 53, baseType: !82, size: 64, offset: 192)
!95 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !89, file: !3, line: 54, baseType: !52, size: 64, offset: 256)
!96 = !DIGlobalVariableExpression(var: !97, expr: !DIExpression())
!97 = distinct !DIGlobalVariable(name: "bpf_skb_load_bytes_relative", scope: !2, file: !98, line: 1813, type: !99, isLocal: true, isDefinition: true)
!98 = !DIFile(filename: "./../libbpf/src/bpf_helper_defs.h", directory: "/media/aadhitya/DATA/XCodes/buzzLB/src", checksumkind: CSK_MD5, checksum: "b2cd2382f6759099a049f8375ad49987")
!99 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !100, size: 64)
!100 = !DISubroutineType(types: !101)
!101 = !{!102, !103, !25, !105, !25, !25}
!102 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!103 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !104, size: 64)
!104 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!105 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!106 = !DIGlobalVariableExpression(var: !107, expr: !DIExpression())
!107 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !98, line: 56, type: !108, isLocal: true, isDefinition: true)
!108 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !109, size: 64)
!109 = !DISubroutineType(types: !110)
!110 = !{!105, !105, !103}
!111 = !DIGlobalVariableExpression(var: !112, expr: !DIExpression())
!112 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !98, line: 78, type: !113, isLocal: true, isDefinition: true)
!113 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !114, size: 64)
!114 = !DISubroutineType(types: !115)
!115 = !{!102, !105, !103, !103, !79}
!116 = !DIGlobalVariableExpression(var: !117, expr: !DIExpression())
!117 = distinct !DIGlobalVariable(name: "bpf_get_prandom_u32", scope: !2, file: !98, line: 193, type: !118, isLocal: true, isDefinition: true)
!118 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !119, size: 64)
!119 = !DISubroutineType(types: !120)
!120 = !{!25}
!121 = !DIGlobalVariableExpression(var: !122, expr: !DIExpression())
!122 = distinct !DIGlobalVariable(name: "bpf_sk_select_reuseport", scope: !2, file: !98, line: 2148, type: !123, isLocal: true, isDefinition: true)
!123 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !124, size: 64)
!124 = !DISubroutineType(types: !125)
!125 = !{!102, !126, !105, !105, !79}
!126 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !127, size: 64)
!127 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "sk_reuseport_md", file: !6, line: 46184, size: 448, elements: !128)
!128 = !{!129, !133, !137, !138, !139, !140, !141, !142, !166}
!129 = !DIDerivedType(tag: DW_TAG_member, scope: !127, file: !6, line: 46185, baseType: !130, size: 64)
!130 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !127, file: !6, line: 46185, size: 64, elements: !131)
!131 = !{!132}
!132 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !130, file: !6, line: 46186, baseType: !105, size: 64)
!133 = !DIDerivedType(tag: DW_TAG_member, scope: !127, file: !6, line: 46188, baseType: !134, size: 64, offset: 64)
!134 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !127, file: !6, line: 46188, size: 64, elements: !135)
!135 = !{!136}
!136 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !134, file: !6, line: 46189, baseType: !105, size: 64)
!137 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !127, file: !6, line: 46191, baseType: !25, size: 32, offset: 128)
!138 = !DIDerivedType(tag: DW_TAG_member, name: "eth_protocol", scope: !127, file: !6, line: 46192, baseType: !25, size: 32, offset: 160)
!139 = !DIDerivedType(tag: DW_TAG_member, name: "ip_protocol", scope: !127, file: !6, line: 46193, baseType: !25, size: 32, offset: 192)
!140 = !DIDerivedType(tag: DW_TAG_member, name: "bind_inany", scope: !127, file: !6, line: 46194, baseType: !25, size: 32, offset: 224)
!141 = !DIDerivedType(tag: DW_TAG_member, name: "hash", scope: !127, file: !6, line: 46195, baseType: !25, size: 32, offset: 256)
!142 = !DIDerivedType(tag: DW_TAG_member, scope: !127, file: !6, line: 46196, baseType: !143, size: 64, offset: 320)
!143 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !127, file: !6, line: 46196, size: 64, elements: !144)
!144 = !{!145}
!145 = !DIDerivedType(tag: DW_TAG_member, name: "sk", scope: !143, file: !6, line: 46197, baseType: !146, size: 64)
!146 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !147, size: 64)
!147 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_sock", file: !6, line: 46097, size: 640, elements: !148)
!148 = !{!149, !150, !151, !152, !153, !154, !155, !156, !158, !159, !161, !162, !163, !164}
!149 = !DIDerivedType(tag: DW_TAG_member, name: "bound_dev_if", scope: !147, file: !6, line: 46098, baseType: !25, size: 32)
!150 = !DIDerivedType(tag: DW_TAG_member, name: "family", scope: !147, file: !6, line: 46099, baseType: !25, size: 32, offset: 32)
!151 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !147, file: !6, line: 46100, baseType: !25, size: 32, offset: 64)
!152 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !147, file: !6, line: 46101, baseType: !25, size: 32, offset: 96)
!153 = !DIDerivedType(tag: DW_TAG_member, name: "mark", scope: !147, file: !6, line: 46102, baseType: !25, size: 32, offset: 128)
!154 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !147, file: !6, line: 46103, baseType: !25, size: 32, offset: 160)
!155 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip4", scope: !147, file: !6, line: 46104, baseType: !25, size: 32, offset: 192)
!156 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip6", scope: !147, file: !6, line: 46105, baseType: !157, size: 128, offset: 224)
!157 = !DICompositeType(tag: DW_TAG_array_type, baseType: !25, size: 128, elements: !28)
!158 = !DIDerivedType(tag: DW_TAG_member, name: "src_port", scope: !147, file: !6, line: 46106, baseType: !25, size: 32, offset: 352)
!159 = !DIDerivedType(tag: DW_TAG_member, name: "dst_port", scope: !147, file: !6, line: 46107, baseType: !160, size: 16, offset: 384)
!160 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !6, line: 7170, baseType: !22)
!161 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip4", scope: !147, file: !6, line: 46108, baseType: !25, size: 32, offset: 416)
!162 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip6", scope: !147, file: !6, line: 46109, baseType: !157, size: 128, offset: 448)
!163 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !147, file: !6, line: 46110, baseType: !25, size: 32, offset: 576)
!164 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_mapping", scope: !147, file: !6, line: 46111, baseType: !165, size: 32, offset: 608)
!165 = !DIDerivedType(tag: DW_TAG_typedef, name: "__s32", file: !6, line: 401, baseType: !45)
!166 = !DIDerivedType(tag: DW_TAG_member, scope: !127, file: !6, line: 46199, baseType: !167, size: 64, offset: 384)
!167 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !127, file: !6, line: 46199, size: 64, elements: !168)
!168 = !{!169}
!169 = !DIDerivedType(tag: DW_TAG_member, name: "migrating_sk", scope: !167, file: !6, line: 46200, baseType: !146, size: 64)
!170 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !6, line: 66181, size: 160, elements: !171)
!171 = !{!172, !175, !176, !177, !178, !179, !180, !181, !182, !184, !185}
!172 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !170, file: !6, line: 66182, baseType: !173, size: 4, flags: DIFlagBitField, extraData: i64 0)
!173 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !6, line: 8, baseType: !174)
!174 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!175 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !170, file: !6, line: 66183, baseType: !173, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!176 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !170, file: !6, line: 66184, baseType: !173, size: 8, offset: 8)
!177 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !170, file: !6, line: 66185, baseType: !160, size: 16, offset: 16)
!178 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !170, file: !6, line: 66186, baseType: !160, size: 16, offset: 32)
!179 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !170, file: !6, line: 66187, baseType: !160, size: 16, offset: 48)
!180 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !170, file: !6, line: 66188, baseType: !173, size: 8, offset: 64)
!181 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !170, file: !6, line: 66189, baseType: !173, size: 8, offset: 72)
!182 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !170, file: !6, line: 66190, baseType: !183, size: 16, offset: 80)
!183 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !6, line: 65086, baseType: !22)
!184 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !170, file: !6, line: 66191, baseType: !27, size: 32, offset: 96)
!185 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !170, file: !6, line: 66192, baseType: !27, size: 32, offset: 128)
!186 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ipv6hdr", file: !6, line: 66207, size: 320, elements: !187)
!187 = !{!188, !189, !190, !194, !195, !196, !197, !212}
!188 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !186, file: !6, line: 66208, baseType: !173, size: 4, flags: DIFlagBitField, extraData: i64 0)
!189 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !186, file: !6, line: 66209, baseType: !173, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!190 = !DIDerivedType(tag: DW_TAG_member, name: "flow_lbl", scope: !186, file: !6, line: 66210, baseType: !191, size: 24, offset: 8)
!191 = !DICompositeType(tag: DW_TAG_array_type, baseType: !173, size: 24, elements: !192)
!192 = !{!193}
!193 = !DISubrange(count: 3)
!194 = !DIDerivedType(tag: DW_TAG_member, name: "payload_len", scope: !186, file: !6, line: 66211, baseType: !160, size: 16, offset: 32)
!195 = !DIDerivedType(tag: DW_TAG_member, name: "nexthdr", scope: !186, file: !6, line: 66212, baseType: !173, size: 8, offset: 48)
!196 = !DIDerivedType(tag: DW_TAG_member, name: "hop_limit", scope: !186, file: !6, line: 66213, baseType: !173, size: 8, offset: 56)
!197 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !186, file: !6, line: 66214, baseType: !198, size: 128, offset: 64)
!198 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "in6_addr", file: !6, line: 9641, size: 128, elements: !199)
!199 = !{!200}
!200 = !DIDerivedType(tag: DW_TAG_member, name: "in6_u", scope: !198, file: !6, line: 9646, baseType: !201, size: 128)
!201 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !198, file: !6, line: 9642, size: 128, elements: !202)
!202 = !{!203, !207, !211}
!203 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr8", scope: !201, file: !6, line: 9643, baseType: !204, size: 128)
!204 = !DICompositeType(tag: DW_TAG_array_type, baseType: !173, size: 128, elements: !205)
!205 = !{!206}
!206 = !DISubrange(count: 16)
!207 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr16", scope: !201, file: !6, line: 9644, baseType: !208, size: 128)
!208 = !DICompositeType(tag: DW_TAG_array_type, baseType: !160, size: 128, elements: !209)
!209 = !{!210}
!210 = !DISubrange(count: 8)
!211 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr32", scope: !201, file: !6, line: 9645, baseType: !26, size: 128)
!212 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !186, file: !6, line: 66215, baseType: !198, size: 128, offset: 192)
!213 = !{i32 7, !"Dwarf Version", i32 5}
!214 = !{i32 2, !"Debug Info Version", i32 3}
!215 = !{i32 1, !"wchar_size", i32 4}
!216 = !{i32 7, !"frame-pointer", i32 2}
!217 = !{!"Ubuntu clang version 14.0.0-1ubuntu1"}
!218 = distinct !DISubprogram(name: "_selector", scope: !3, file: !3, line: 115, type: !219, scopeLine: 115, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !221)
!219 = !DISubroutineType(types: !220)
!220 = !{!5, !126}
!221 = !{!222, !223, !224, !225, !226, !227, !228, !229}
!222 = !DILocalVariable(name: "reuse", arg: 1, scope: !218, file: !3, line: 115, type: !126)
!223 = !DILocalVariable(name: "action", scope: !218, file: !3, line: 116, type: !5)
!224 = !DILocalVariable(name: "ip", scope: !218, file: !3, line: 117, type: !170)
!225 = !DILocalVariable(name: "ipv6", scope: !218, file: !3, line: 118, type: !186)
!226 = !DILocalVariable(name: "key", scope: !218, file: !3, line: 120, type: !24)
!227 = !DILocalVariable(name: "is_ipv4", scope: !218, file: !3, line: 122, type: !45)
!228 = !DILocalVariable(name: "targets", scope: !218, file: !3, line: 123, type: !105)
!229 = !DILocalVariable(name: "balancer_count", scope: !218, file: !3, line: 149, type: !230)
!230 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !33, size: 64)
!231 = !DILocation(line: 0, scope: !218)
!232 = !DILocation(line: 117, column: 3, scope: !218)
!233 = !DILocation(line: 117, column: 16, scope: !218)
!234 = !DILocation(line: 118, column: 3, scope: !218)
!235 = !DILocation(line: 118, column: 18, scope: !218)
!236 = !DILocation(line: 120, column: 3, scope: !218)
!237 = !DILocation(line: 122, column: 24, scope: !218)
!238 = !{!239, !242, i64 20}
!239 = !{!"sk_reuseport_md", !240, i64 0, !240, i64 8, !242, i64 16, !242, i64 20, !242, i64 24, !242, i64 28, !242, i64 32, !240, i64 40, !240, i64 48}
!240 = !{!"omnipotent char", !241, i64 0}
!241 = !{!"Simple C/C++ TBAA"}
!242 = !{!"int", !240, i64 0}
!243 = !DILocation(line: 122, column: 37, scope: !218)
!244 = !DILocation(line: 126, column: 3, scope: !218)
!245 = !DILocation(line: 127, column: 3, scope: !218)
!246 = !DILocation(line: 129, column: 18, scope: !218)
!247 = !{!239, !242, i64 24}
!248 = !DILocation(line: 129, column: 3, scope: !218)
!249 = !DILocation(line: 135, column: 7, scope: !250)
!250 = distinct !DILexicalBlock(scope: !218, file: !3, line: 129, column: 31)
!251 = !DILocation(line: 0, scope: !250)
!252 = !DILocation(line: 143, column: 6, scope: !218)
!253 = !DILocation(line: 144, column: 5, scope: !254)
!254 = distinct !DILexicalBlock(scope: !255, file: !3, line: 143, column: 14)
!255 = distinct !DILexicalBlock(scope: !218, file: !3, line: 143, column: 6)
!256 = !DILocation(line: 145, column: 3, scope: !254)
!257 = !DILocation(line: 146, column: 5, scope: !258)
!258 = distinct !DILexicalBlock(scope: !255, file: !3, line: 145, column: 10)
!259 = !DILocation(line: 149, column: 31, scope: !218)
!260 = !DILocation(line: 150, column: 8, scope: !261)
!261 = distinct !DILexicalBlock(scope: !218, file: !3, line: 150, column: 7)
!262 = !DILocation(line: 150, column: 23, scope: !261)
!263 = !DILocation(line: 150, column: 26, scope: !261)
!264 = !{!242, !242, i64 0}
!265 = !DILocation(line: 150, column: 42, scope: !261)
!266 = !DILocation(line: 150, column: 7, scope: !218)
!267 = !DILocation(line: 152, column: 5, scope: !268)
!268 = distinct !DILexicalBlock(scope: !261, file: !3, line: 150, column: 48)
!269 = !DILocation(line: 153, column: 3, scope: !268)
!270 = !DILocation(line: 160, column: 6, scope: !218)
!271 = !DILocation(line: 161, column: 37, scope: !272)
!272 = distinct !DILexicalBlock(scope: !273, file: !3, line: 160, column: 14)
!273 = distinct !DILexicalBlock(scope: !218, file: !3, line: 160, column: 6)
!274 = !{!275, !242, i64 12}
!275 = !{!"iphdr", !240, i64 0, !240, i64 0, !240, i64 1, !276, i64 2, !276, i64 4, !276, i64 6, !240, i64 8, !240, i64 9, !276, i64 10, !242, i64 12, !242, i64 16}
!276 = !{!"short", !240, i64 0}
!277 = !DILocation(line: 161, column: 16, scope: !272)
!278 = !DILocalVariable(name: "ip_p1", arg: 1, scope: !279, file: !3, line: 80, type: !24)
!279 = distinct !DISubprogram(name: "hash", scope: !3, file: !3, line: 80, type: !280, scopeLine: 80, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !282)
!280 = !DISubroutineType(types: !281)
!281 = !{!24, !24, !24, !24, !24}
!282 = !{!278, !283, !284, !285, !286, !287, !288, !289, !290}
!283 = !DILocalVariable(name: "ip_p2", arg: 2, scope: !279, file: !3, line: 80, type: !24)
!284 = !DILocalVariable(name: "ip_p3", arg: 3, scope: !279, file: !3, line: 80, type: !24)
!285 = !DILocalVariable(name: "ip_p4", arg: 4, scope: !279, file: !3, line: 80, type: !24)
!286 = !DILocalVariable(name: "a", scope: !279, file: !3, line: 81, type: !24)
!287 = !DILocalVariable(name: "b", scope: !279, file: !3, line: 81, type: !24)
!288 = !DILocalVariable(name: "c", scope: !279, file: !3, line: 81, type: !24)
!289 = !DILocalVariable(name: "initval", scope: !279, file: !3, line: 81, type: !24)
!290 = !DILocalVariable(name: "n", scope: !279, file: !3, line: 81, type: !49)
!291 = !DILocation(line: 0, scope: !279, inlinedAt: !292)
!292 = distinct !DILocation(line: 161, column: 11, scope: !272)
!293 = !DILocation(line: 84, column: 7, scope: !279, inlinedAt: !292)
!294 = !DILocation(line: 85, column: 9, scope: !295, inlinedAt: !292)
!295 = distinct !DILexicalBlock(scope: !279, file: !3, line: 85, column: 7)
!296 = !DILocation(line: 85, column: 7, scope: !279, inlinedAt: !292)
!297 = !DILocation(line: 90, column: 7, scope: !298, inlinedAt: !292)
!298 = distinct !DILexicalBlock(scope: !279, file: !3, line: 90, column: 7)
!299 = !DILocation(line: 90, column: 10, scope: !298, inlinedAt: !292)
!300 = !DILocation(line: 90, column: 7, scope: !279, inlinedAt: !292)
!301 = !DILocation(line: 92, column: 10, scope: !302, inlinedAt: !292)
!302 = distinct !DILexicalBlock(scope: !298, file: !3, line: 90, column: 16)
!303 = !DILocation(line: 92, column: 8, scope: !302, inlinedAt: !292)
!304 = !DILocation(line: 97, column: 3, scope: !302, inlinedAt: !292)
!305 = !DILocation(line: 99, column: 13, scope: !279, inlinedAt: !292)
!306 = !DILocation(line: 101, column: 11, scope: !279, inlinedAt: !292)
!307 = !DILocation(line: 102, column: 37, scope: !279, inlinedAt: !292)
!308 = !DILocalVariable(name: "word", arg: 1, scope: !309, file: !3, line: 78, type: !25)
!309 = distinct !DISubprogram(name: "rol32", scope: !3, file: !3, line: 78, type: !310, scopeLine: 78, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !312)
!310 = !DISubroutineType(types: !311)
!311 = !{!25, !25, !7}
!312 = !{!308, !313}
!313 = !DILocalVariable(name: "shift", arg: 2, scope: !309, file: !3, line: 78, type: !7)
!314 = !DILocation(line: 0, scope: !309, inlinedAt: !315)
!315 = distinct !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !292)
!316 = distinct !DILexicalBlock(scope: !279, file: !3, line: 106, column: 3)
!317 = !DILocation(line: 78, column: 91, scope: !309, inlinedAt: !315)
!318 = !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !292)
!319 = !DILocation(line: 0, scope: !309, inlinedAt: !320)
!320 = distinct !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !292)
!321 = !DILocation(line: 78, column: 91, scope: !309, inlinedAt: !320)
!322 = !DILocation(line: 0, scope: !309, inlinedAt: !323)
!323 = distinct !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !292)
!324 = !DILocation(line: 78, column: 91, scope: !309, inlinedAt: !323)
!325 = !DILocation(line: 0, scope: !309, inlinedAt: !326)
!326 = distinct !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !292)
!327 = !DILocation(line: 78, column: 91, scope: !309, inlinedAt: !326)
!328 = !DILocation(line: 0, scope: !309, inlinedAt: !329)
!329 = distinct !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !292)
!330 = !DILocation(line: 78, column: 91, scope: !309, inlinedAt: !329)
!331 = !DILocation(line: 0, scope: !309, inlinedAt: !332)
!332 = distinct !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !292)
!333 = !DILocation(line: 78, column: 91, scope: !309, inlinedAt: !332)
!334 = !DILocation(line: 0, scope: !309, inlinedAt: !335)
!335 = distinct !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !292)
!336 = !DILocation(line: 78, column: 91, scope: !309, inlinedAt: !335)
!337 = !DILocation(line: 107, column: 3, scope: !279, inlinedAt: !292)
!338 = !DILocation(line: 164, column: 25, scope: !339)
!339 = distinct !DILexicalBlock(scope: !273, file: !3, line: 162, column: 10)
!340 = !{!240, !240, i64 0}
!341 = !DILocation(line: 164, column: 7, scope: !339)
!342 = !DILocation(line: 165, column: 25, scope: !339)
!343 = !DILocation(line: 165, column: 7, scope: !339)
!344 = !DILocation(line: 166, column: 25, scope: !339)
!345 = !DILocation(line: 166, column: 7, scope: !339)
!346 = !DILocation(line: 167, column: 25, scope: !339)
!347 = !DILocation(line: 167, column: 7, scope: !339)
!348 = !DILocation(line: 0, scope: !279, inlinedAt: !349)
!349 = distinct !DILocation(line: 163, column: 11, scope: !339)
!350 = !DILocation(line: 84, column: 7, scope: !279, inlinedAt: !349)
!351 = !DILocation(line: 85, column: 9, scope: !295, inlinedAt: !349)
!352 = !DILocation(line: 85, column: 7, scope: !279, inlinedAt: !349)
!353 = !DILocation(line: 90, column: 7, scope: !298, inlinedAt: !349)
!354 = !DILocation(line: 90, column: 10, scope: !298, inlinedAt: !349)
!355 = !DILocation(line: 90, column: 7, scope: !279, inlinedAt: !349)
!356 = !DILocation(line: 92, column: 10, scope: !302, inlinedAt: !349)
!357 = !DILocation(line: 92, column: 8, scope: !302, inlinedAt: !349)
!358 = !DILocation(line: 97, column: 3, scope: !302, inlinedAt: !349)
!359 = !DILocation(line: 99, column: 13, scope: !279, inlinedAt: !349)
!360 = !DILocation(line: 101, column: 11, scope: !279, inlinedAt: !349)
!361 = !DILocation(line: 102, column: 13, scope: !279, inlinedAt: !349)
!362 = !DILocation(line: 102, column: 21, scope: !279, inlinedAt: !349)
!363 = !DILocation(line: 102, column: 29, scope: !279, inlinedAt: !349)
!364 = !DILocation(line: 102, column: 37, scope: !279, inlinedAt: !349)
!365 = !DILocation(line: 0, scope: !309, inlinedAt: !366)
!366 = distinct !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !349)
!367 = !DILocation(line: 78, column: 91, scope: !309, inlinedAt: !366)
!368 = !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !349)
!369 = !DILocation(line: 0, scope: !309, inlinedAt: !370)
!370 = distinct !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !349)
!371 = !DILocation(line: 78, column: 91, scope: !309, inlinedAt: !370)
!372 = !DILocation(line: 0, scope: !309, inlinedAt: !373)
!373 = distinct !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !349)
!374 = !DILocation(line: 78, column: 91, scope: !309, inlinedAt: !373)
!375 = !DILocation(line: 0, scope: !309, inlinedAt: !376)
!376 = distinct !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !349)
!377 = !DILocation(line: 78, column: 91, scope: !309, inlinedAt: !376)
!378 = !DILocation(line: 0, scope: !309, inlinedAt: !379)
!379 = distinct !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !349)
!380 = !DILocation(line: 78, column: 91, scope: !309, inlinedAt: !379)
!381 = !DILocation(line: 0, scope: !309, inlinedAt: !382)
!382 = distinct !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !349)
!383 = !DILocation(line: 78, column: 91, scope: !309, inlinedAt: !382)
!384 = !DILocation(line: 0, scope: !309, inlinedAt: !385)
!385 = distinct !DILocation(line: 106, column: 3, scope: !316, inlinedAt: !349)
!386 = !DILocation(line: 78, column: 91, scope: !309, inlinedAt: !385)
!387 = !DILocation(line: 107, column: 3, scope: !279, inlinedAt: !349)
!388 = !DILocation(line: 0, scope: !273)
!389 = !DILocation(line: 180, column: 7, scope: !390)
!390 = distinct !DILexicalBlock(scope: !218, file: !3, line: 180, column: 7)
!391 = !DILocation(line: 180, column: 56, scope: !390)
!392 = !DILocation(line: 193, column: 1, scope: !218)
