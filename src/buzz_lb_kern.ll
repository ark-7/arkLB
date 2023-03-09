; ModuleID = 'buzz_lb_kern.c'
source_filename = "buzz_lb_kern.c"
target datalayout = "e-m:e-p:64:64-i64:64-i128:128-n32:64-S128"
target triple = "bpf"

%struct.anon = type { [4 x i32]*, [4 x i32]*, [4 x i32]*, [128 x i32]*, [1 x i32]* }
%struct.anon.4 = type { [20 x i32]*, i32*, i64*, [128 x i32]*, [1 x i32]* }
%struct.anon.5 = type { [20 x i32]*, i32*, i64*, [128 x i32]*, [1 x i32]* }
%struct.anon.6 = type { [2 x i32]*, i32*, i32*, [1 x i32]*, [1 x i32]* }
%struct.anon.7 = type { [2 x i32]*, i32*, i32*, [1 x i32]*, [1 x i32]* }
%struct.xdp_md = type { i32, i32, i32, i32, i32, i32 }
%struct.S = type { i64 }
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
@balancer_max = dso_local constant i32 128, align 4, !dbg !75
@buzz_lb_xdp.____fmt = internal constant [23 x i8] c"Heya! XDP buzzLB here!\00", align 1, !dbg !78
@perf_map = dso_local global %struct.anon zeroinitializer, section ".maps", align 8, !dbg !207
@buzz_lb_xdp.____fmt.1 = internal constant [30 x i8] c"perf_event_output failed: %d\0A\00", align 1, !dbg !136
@buzz_lb_xdp.____fmt.2 = internal constant [27 x i8] c"Got non-TCP packet from %x\00", align 1, !dbg !141
@buzz_lb_xdp.____fmt.3 = internal constant [23 x i8] c"Got TCP packet from %x\00", align 1, !dbg !146
@tcp_balancing_targets = dso_local global %struct.anon.4 zeroinitializer, section ".maps", align 8, !dbg !178
@udp_balancing_targets = dso_local global %struct.anon.5 zeroinitializer, section ".maps", align 8, !dbg !198
@size = dso_local global %struct.anon.6 zeroinitializer, section ".maps", align 8, !dbg !169
@_license = dso_local global [4 x i8] c"GPL\00", section "license", align 1, !dbg !148
@nonce = dso_local global %struct.anon.7 zeroinitializer, section ".maps", align 8, !dbg !151
@"llvm.xdp_md:0:4$0:1" = external global i64, !llvm.preserve.access.index !85 #0
@"llvm.xdp_md:0:0$0:0" = external global i64, !llvm.preserve.access.index !85 #0
@"llvm.ethhdr:0:12$0:2" = external global i64, !llvm.preserve.access.index !105 #0
@"llvm.ethhdr:0:11$0:1:5" = external global i64, !llvm.preserve.access.index !105 #0
@"llvm.iphdr:0:9$0:7" = external global i64, !llvm.preserve.access.index !113 #0
@"llvm.iphdr:0:12$0:9" = external global i64, !llvm.preserve.access.index !113 #0
@"llvm.iphdr:0:16$0:10" = external global i64, !llvm.preserve.access.index !113 #0
@"llvm.ethhdr:0:5$0:0:5" = external global i64, !llvm.preserve.access.index !105 #0
@"llvm.iphdr:0:10$0:8" = external global i64, !llvm.preserve.access.index !113 #0
@"llvm.sk_reuseport_md:0:20$0:3" = external global i64, !llvm.preserve.access.index !272 #0
@"llvm.sk_reuseport_md:0:24$0:4" = external global i64, !llvm.preserve.access.index !272 #0
@"llvm.ipv6hdr:0:8$0:6:0:2:0" = external global i64, !llvm.preserve.access.index !314 #0
@"llvm.ipv6hdr:0:12$0:6:0:2:1" = external global i64, !llvm.preserve.access.index !314 #0
@"llvm.ipv6hdr:0:16$0:6:0:2:2" = external global i64, !llvm.preserve.access.index !314 #0
@"llvm.ipv6hdr:0:20$0:6:0:2:3" = external global i64, !llvm.preserve.access.index !314 #0
@llvm.compiler.used = appending global [8 x i8*] [i8* getelementptr inbounds ([4 x i8], [4 x i8]* @_license, i32 0, i32 0), i8* bitcast (i32 (%struct.sk_reuseport_md*)* @_selector to i8*), i8* bitcast (i32 (%struct.xdp_md*)* @buzz_lb_xdp to i8*), i8* bitcast (%struct.anon.7* @nonce to i8*), i8* bitcast (%struct.anon* @perf_map to i8*), i8* bitcast (%struct.anon.6* @size to i8*), i8* bitcast (%struct.anon.4* @tcp_balancing_targets to i8*), i8* bitcast (%struct.anon.5* @udp_balancing_targets to i8*)], section "llvm.metadata"

; Function Attrs: nounwind
define dso_local i32 @buzz_lb_xdp(%struct.xdp_md* noundef %0) #1 section "xdp_buzz_lb" !dbg !80 {
  %2 = alloca %struct.S, align 8
  call void @llvm.dbg.value(metadata %struct.xdp_md* %0, metadata !94, metadata !DIExpression()), !dbg !346
  %3 = load i64, i64* @"llvm.xdp_md:0:0$0:0", align 8
  %4 = bitcast %struct.xdp_md* %0 to i8*
  %5 = getelementptr i8, i8* %4, i64 %3
  %6 = bitcast i8* %5 to i32*
  %7 = tail call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 1, i32* %6)
  %8 = load i32, i32* %7, align 4, !dbg !347, !tbaa !348
  %9 = zext i32 %8 to i64, !dbg !353
  %10 = inttoptr i64 %9 to i8*, !dbg !354
  call void @llvm.dbg.value(metadata i8* %10, metadata !95, metadata !DIExpression()), !dbg !346
  %11 = load i64, i64* @"llvm.xdp_md:0:4$0:1", align 8
  %12 = getelementptr i8, i8* %4, i64 %11
  %13 = bitcast i8* %12 to i32*
  %14 = tail call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 0, i32* %13)
  %15 = load i32, i32* %14, align 4, !dbg !355, !tbaa !356
  %16 = zext i32 %15 to i64, !dbg !357
  %17 = inttoptr i64 %16 to i8*, !dbg !358
  call void @llvm.dbg.value(metadata i8* %17, metadata !96, metadata !DIExpression()), !dbg !346
  %18 = tail call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([23 x i8], [23 x i8]* @buzz_lb_xdp.____fmt, i64 0, i64 0), i32 noundef 23) #7, !dbg !359
  %19 = bitcast %struct.S* %2 to i8*, !dbg !361
  call void @llvm.lifetime.start.p0i8(i64 8, i8* nonnull %19) #7, !dbg !361
  call void @llvm.dbg.declare(metadata %struct.S* %2, metadata !97, metadata !DIExpression()), !dbg !362
  %20 = tail call i64 inttoptr (i64 5 to i64 ()*)() #7, !dbg !363
  %21 = getelementptr inbounds %struct.S, %struct.S* %2, i64 0, i32 0, !dbg !364
  store i64 %20, i64* %21, align 8, !dbg !365, !tbaa !366
  %22 = call i64 inttoptr (i64 25 to i64 (i8*, i8*, i64, i8*, i64)*)(i8* noundef %4, i8* noundef bitcast (%struct.anon* @perf_map to i8*), i64 noundef 0, i8* noundef nonnull %19, i64 noundef 8) #7, !dbg !369
  %23 = trunc i64 %22 to i32, !dbg !369
  call void @llvm.dbg.value(metadata i32 %23, metadata !102, metadata !DIExpression()), !dbg !346
  %24 = icmp eq i32 %23, 0, !dbg !370
  br i1 %24, label %27, label %25, !dbg !372

25:                                               ; preds = %1
  %26 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([30 x i8], [30 x i8]* @buzz_lb_xdp.____fmt.1, i64 0, i64 0), i32 noundef 30, i32 noundef %23) #7, !dbg !373
  br label %27, !dbg !375

27:                                               ; preds = %25, %1
  call void @llvm.dbg.value(metadata i8* %10, metadata !103, metadata !DIExpression()), !dbg !346
  %28 = getelementptr i8, i8* %10, i64 14, !dbg !376
  %29 = icmp ugt i8* %28, %17, !dbg !378
  br i1 %29, label %128, label %30, !dbg !379

30:                                               ; preds = %27
  %31 = load i64, i64* @"llvm.ethhdr:0:12$0:2", align 8
  %32 = getelementptr i8, i8* %10, i64 %31
  %33 = bitcast i8* %32 to i16*
  %34 = call i16* @llvm.bpf.passthrough.p0i16.p0i16(i32 11, i16* %33)
  %35 = load i16, i16* %34, align 2, !dbg !380, !tbaa !382
  %36 = icmp eq i16 %35, 8, !dbg !385
  br i1 %36, label %37, label %128, !dbg !386

37:                                               ; preds = %30
  call void @llvm.dbg.value(metadata i8* %28, metadata !111, metadata !DIExpression()), !dbg !346
  %38 = getelementptr i8, i8* %10, i64 34, !dbg !387
  %39 = icmp ugt i8* %38, %17, !dbg !389
  br i1 %39, label %128, label %40, !dbg !390

40:                                               ; preds = %37
  %41 = load i64, i64* @"llvm.iphdr:0:9$0:7", align 8
  %42 = getelementptr i8, i8* %28, i64 %41
  %43 = call i8* @llvm.bpf.passthrough.p0i8.p0i8(i32 4, i8* %42)
  %44 = load i8, i8* %43, align 1, !dbg !391, !tbaa !393
  %45 = icmp eq i8 %44, 6, !dbg !395
  br i1 %45, label %53, label %46, !dbg !396

46:                                               ; preds = %40
  %47 = load i64, i64* @"llvm.iphdr:0:12$0:9", align 8
  %48 = getelementptr i8, i8* %28, i64 %47
  %49 = bitcast i8* %48 to i32*
  %50 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 5, i32* %49)
  %51 = load i32, i32* %50, align 4, !dbg !397, !tbaa !399
  %52 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([27 x i8], [27 x i8]* @buzz_lb_xdp.____fmt.2, i64 0, i64 0), i32 noundef 27, i32 noundef %51) #7, !dbg !397
  br label %53, !dbg !400

53:                                               ; preds = %46, %40
  %54 = load i64, i64* @"llvm.iphdr:0:12$0:9", align 8
  %55 = getelementptr i8, i8* %28, i64 %54
  %56 = bitcast i8* %55 to i32*
  %57 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 6, i32* %56)
  %58 = load i32, i32* %57, align 4, !dbg !401, !tbaa !399
  %59 = call i64 (i8*, i32, ...) inttoptr (i64 6 to i64 (i8*, i32, ...)*)(i8* noundef getelementptr inbounds ([23 x i8], [23 x i8]* @buzz_lb_xdp.____fmt.3, i64 0, i64 0), i32 noundef 23, i32 noundef %58) #7, !dbg !401
  %60 = load i64, i64* @"llvm.iphdr:0:12$0:9", align 8
  %61 = getelementptr i8, i8* %28, i64 %60
  %62 = bitcast i8* %61 to i32*
  %63 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 7, i32* %62)
  %64 = load i32, i32* %63, align 4, !dbg !403, !tbaa !399
  %65 = icmp eq i32 %64, 67113388, !dbg !404
  br i1 %65, label %66, label %81, !dbg !405

66:                                               ; preds = %53
  call void @llvm.dbg.value(metadata i8 2, metadata !128, metadata !DIExpression()), !dbg !406
  %67 = call i64 inttoptr (i64 5 to i64 ()*)() #7, !dbg !407
  %68 = and i64 %67, 1, !dbg !409
  %69 = icmp eq i64 %68, 0, !dbg !409
  %70 = select i1 %69, i8 2, i8 3, !dbg !410
  call void @llvm.dbg.value(metadata i8 %70, metadata !128, metadata !DIExpression()), !dbg !406
  %71 = zext i8 %70 to i32
  %72 = shl nuw nsw i32 %71, 24, !dbg !411
  %73 = or i32 %72, 4524, !dbg !411
  %74 = load i64, i64* @"llvm.iphdr:0:16$0:10", align 8
  %75 = getelementptr i8, i8* %28, i64 %74
  %76 = bitcast i8* %75 to i32*
  %77 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 8, i32* %76)
  store i32 %73, i32* %77, align 4, !dbg !412, !tbaa !413
  %78 = load i64, i64* @"llvm.ethhdr:0:5$0:0:5", align 8
  %79 = getelementptr i8, i8* %10, i64 %78
  %80 = call i8* @llvm.bpf.passthrough.p0i8.p0i8(i32 12, i8* %79)
  store i8 %70, i8* %80, align 1, !dbg !414, !tbaa !415
  br label %89, !dbg !416

81:                                               ; preds = %53
  %82 = load i64, i64* @"llvm.iphdr:0:16$0:10", align 8
  %83 = getelementptr i8, i8* %28, i64 %82
  %84 = bitcast i8* %83 to i32*
  %85 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 13, i32* %84)
  store i32 67113388, i32* %85, align 4, !dbg !417, !tbaa !413
  %86 = load i64, i64* @"llvm.ethhdr:0:5$0:0:5", align 8
  %87 = getelementptr i8, i8* %10, i64 %86
  %88 = call i8* @llvm.bpf.passthrough.p0i8.p0i8(i32 14, i8* %87)
  store i8 4, i8* %88, align 1, !dbg !419, !tbaa !415
  br label %89

89:                                               ; preds = %81, %66
  %90 = load i64, i64* @"llvm.iphdr:0:12$0:9", align 8
  %91 = getelementptr i8, i8* %28, i64 %90
  %92 = bitcast i8* %91 to i32*
  %93 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 15, i32* %92)
  store i32 83890604, i32* %93, align 4, !dbg !420, !tbaa !399
  %94 = load i64, i64* @"llvm.ethhdr:0:11$0:1:5", align 8
  %95 = getelementptr i8, i8* %10, i64 %94
  %96 = call i8* @llvm.bpf.passthrough.p0i8.p0i8(i32 3, i8* %95)
  store i8 5, i8* %96, align 1, !dbg !421, !tbaa !415
  call void @llvm.dbg.value(metadata i8* %28, metadata !422, metadata !DIExpression()) #7, !dbg !428
  %97 = load i64, i64* @"llvm.iphdr:0:10$0:8", align 8
  %98 = getelementptr i8, i8* %28, i64 %97
  %99 = bitcast i8* %98 to i16*
  %100 = call i16* @llvm.bpf.passthrough.p0i16.p0i16(i32 17, i16* %99) #7
  store i16 0, i16* %100, align 2, !dbg !430, !tbaa !431
  %101 = bitcast i8* %28 to i32*, !dbg !432
  %102 = call i64 inttoptr (i64 28 to i64 (i32*, i32, i32*, i32, i32)*)(i32* noundef null, i32 noundef 0, i32* noundef %101, i32 noundef 20, i32 noundef 0) #7, !dbg !433
  call void @llvm.dbg.value(metadata i64 %102, metadata !427, metadata !DIExpression()) #7, !dbg !428
  call void @llvm.dbg.value(metadata i64 %102, metadata !434, metadata !DIExpression()) #7, !dbg !440
  call void @llvm.dbg.value(metadata i32 0, metadata !439, metadata !DIExpression()) #7, !dbg !440
  call void @llvm.dbg.value(metadata i32 0, metadata !439, metadata !DIExpression()) #7, !dbg !440
  call void @llvm.dbg.value(metadata i64 %102, metadata !434, metadata !DIExpression()) #7, !dbg !440
  %103 = icmp ult i64 %102, 65536, !dbg !442
  %104 = lshr i64 %102, 16, !dbg !447
  %105 = and i64 %102, 65535, !dbg !447
  %106 = add nuw nsw i64 %105, %104, !dbg !447
  %107 = select i1 %103, i64 %102, i64 %106, !dbg !447
  call void @llvm.dbg.value(metadata i64 %107, metadata !434, metadata !DIExpression()) #7, !dbg !440
  call void @llvm.dbg.value(metadata i32 1, metadata !439, metadata !DIExpression()) #7, !dbg !440
  call void @llvm.dbg.value(metadata i32 1, metadata !439, metadata !DIExpression()) #7, !dbg !440
  call void @llvm.dbg.value(metadata i64 %107, metadata !434, metadata !DIExpression()) #7, !dbg !440
  %108 = icmp ult i64 %107, 65536, !dbg !442
  %109 = lshr i64 %107, 16, !dbg !447
  %110 = and i64 %107, 65535, !dbg !447
  %111 = add nuw nsw i64 %110, %109, !dbg !447
  %112 = select i1 %108, i64 %107, i64 %111, !dbg !447
  call void @llvm.dbg.value(metadata i64 %112, metadata !434, metadata !DIExpression()) #7, !dbg !440
  call void @llvm.dbg.value(metadata i32 2, metadata !439, metadata !DIExpression()) #7, !dbg !440
  call void @llvm.dbg.value(metadata i32 2, metadata !439, metadata !DIExpression()) #7, !dbg !440
  call void @llvm.dbg.value(metadata i64 %112, metadata !434, metadata !DIExpression()) #7, !dbg !440
  %113 = icmp ult i64 %112, 65536, !dbg !442
  %114 = lshr i64 %112, 16, !dbg !447
  %115 = and i64 %112, 65535, !dbg !447
  %116 = add nuw nsw i64 %115, %114, !dbg !447
  %117 = select i1 %113, i64 %112, i64 %116, !dbg !447
  call void @llvm.dbg.value(metadata i64 %117, metadata !434, metadata !DIExpression()) #7, !dbg !440
  call void @llvm.dbg.value(metadata i32 3, metadata !439, metadata !DIExpression()) #7, !dbg !440
  call void @llvm.dbg.value(metadata i32 3, metadata !439, metadata !DIExpression()) #7, !dbg !440
  call void @llvm.dbg.value(metadata i64 %117, metadata !434, metadata !DIExpression()) #7, !dbg !440
  %118 = icmp ult i64 %117, 65536, !dbg !442
  %119 = lshr i64 %117, 16, !dbg !447
  %120 = select i1 %118, i64 65536, i64 %119, !dbg !447
  %121 = add nuw nsw i64 %120, %117, !dbg !447
  call void @llvm.dbg.value(metadata i64 undef, metadata !434, metadata !DIExpression()) #7, !dbg !440
  call void @llvm.dbg.value(metadata i32 4, metadata !439, metadata !DIExpression()) #7, !dbg !440
  %122 = trunc i64 %121 to i16, !dbg !448
  %123 = xor i16 %122, -1, !dbg !448
  %124 = load i64, i64* @"llvm.iphdr:0:10$0:8", align 8
  %125 = getelementptr i8, i8* %28, i64 %124
  %126 = bitcast i8* %125 to i16*
  %127 = call i16* @llvm.bpf.passthrough.p0i16.p0i16(i32 16, i16* %126)
  store i16 %123, i16* %127, align 2, !dbg !449, !tbaa !431
  br label %128, !dbg !450

128:                                              ; preds = %89, %37, %30, %27
  %129 = phi i32 [ 0, %27 ], [ 2, %30 ], [ 3, %89 ], [ 0, %37 ], !dbg !346
  call void @llvm.lifetime.end.p0i8(i64 8, i8* nonnull %19) #7, !dbg !451
  ret i32 %129, !dbg !451
}

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #3

; Function Attrs: argmemonly mustprogress nofree nosync nounwind willreturn
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #3

; Function Attrs: nounwind
define dso_local i32 @_selector(%struct.sk_reuseport_md* noundef %0) #1 section "sk_reuseport/selector" !dbg !452 {
  %2 = alloca %struct.iphdr, align 4
  %3 = alloca %struct.ipv6hdr, align 4
  %4 = alloca i32, align 4
  call void @llvm.dbg.value(metadata %struct.sk_reuseport_md* %0, metadata !456, metadata !DIExpression()), !dbg !465
  %5 = getelementptr inbounds %struct.iphdr, %struct.iphdr* %2, i64 0, i32 0, !dbg !466
  call void @llvm.lifetime.start.p0i8(i64 20, i8* nonnull %5) #7, !dbg !466
  call void @llvm.dbg.declare(metadata %struct.iphdr* %2, metadata !458, metadata !DIExpression()), !dbg !467
  %6 = getelementptr inbounds %struct.ipv6hdr, %struct.ipv6hdr* %3, i64 0, i32 0, !dbg !468
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %6) #7, !dbg !468
  call void @llvm.dbg.declare(metadata %struct.ipv6hdr* %3, metadata !459, metadata !DIExpression()), !dbg !469
  %7 = bitcast i32* %4 to i8*, !dbg !470
  call void @llvm.lifetime.start.p0i8(i64 4, i8* nonnull %7) #7, !dbg !470
  %8 = load i64, i64* @"llvm.sk_reuseport_md:0:20$0:3", align 8
  %9 = bitcast %struct.sk_reuseport_md* %0 to i8*
  %10 = getelementptr i8, i8* %9, i64 %8
  %11 = bitcast i8* %10 to i32*
  %12 = tail call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 18, i32* %11)
  %13 = load i32, i32* %12, align 4, !dbg !471, !tbaa !472
  %14 = icmp eq i32 %13, 8, !dbg !474
  call void @llvm.dbg.value(metadata i1 %14, metadata !461, metadata !DIExpression(DW_OP_LLVM_convert, 1, DW_ATE_unsigned, DW_OP_LLVM_convert, 32, DW_ATE_unsigned, DW_OP_stack_value)), !dbg !465
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 4 dereferenceable(40) %6, i8 0, i64 40, i1 false), !dbg !475
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 4 dereferenceable(20) %5, i8 0, i64 20, i1 false), !dbg !476
  %15 = load i64, i64* @"llvm.sk_reuseport_md:0:24$0:4", align 8
  %16 = getelementptr i8, i8* %9, i64 %15
  %17 = bitcast i8* %16 to i32*
  %18 = tail call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 19, i32* %17)
  %19 = load i32, i32* %18, align 8, !dbg !477, !tbaa !478
  switch i32 %19, label %144 [
    i32 6, label %21
    i32 17, label %20
  ], !dbg !479

20:                                               ; preds = %1
  call void @llvm.dbg.value(metadata i8* bitcast (%struct.anon.5* @udp_balancing_targets to i8*), metadata !462, metadata !DIExpression()), !dbg !465
  br label %21, !dbg !480

21:                                               ; preds = %1, %20
  %22 = phi i8* [ bitcast (%struct.anon.5* @udp_balancing_targets to i8*), %20 ], [ bitcast (%struct.anon.4* @tcp_balancing_targets to i8*), %1 ], !dbg !482
  call void @llvm.dbg.value(metadata i8* %22, metadata !462, metadata !DIExpression()), !dbg !465
  br i1 %14, label %23, label %25, !dbg !483

23:                                               ; preds = %21
  %24 = call i64 inttoptr (i64 68 to i64 (i8*, i32, i8*, i32, i32)*)(i8* noundef %9, i32 noundef 0, i8* noundef nonnull %5, i32 noundef 20, i32 noundef 1) #7, !dbg !484
  br label %27, !dbg !487

25:                                               ; preds = %21
  %26 = call i64 inttoptr (i64 68 to i64 (i8*, i32, i8*, i32, i32)*)(i8* noundef %9, i32 noundef 0, i8* noundef nonnull %6, i32 noundef 40, i32 noundef 1) #7, !dbg !488
  br label %27

27:                                               ; preds = %25, %23
  %28 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.6* @size to i8*), i8* noundef bitcast (i32* @zero to i8*)) #7, !dbg !490
  %29 = bitcast i8* %28 to i32*, !dbg !490
  call void @llvm.dbg.value(metadata i32* %29, metadata !463, metadata !DIExpression()), !dbg !465
  %30 = icmp eq i8* %28, null, !dbg !491
  br i1 %30, label %34, label %31, !dbg !493

31:                                               ; preds = %27
  %32 = load i32, i32* %29, align 4, !dbg !494, !tbaa !495
  %33 = icmp eq i32 %32, 0, !dbg !496
  br i1 %33, label %34, label %36, !dbg !497

34:                                               ; preds = %31, %27
  call void @llvm.dbg.value(metadata i32* @balancer_max, metadata !463, metadata !DIExpression()), !dbg !465
  %35 = call i64 inttoptr (i64 2 to i64 (i8*, i8*, i8*, i64)*)(i8* noundef bitcast (%struct.anon.6* @size to i8*), i8* noundef bitcast (i32* @zero to i8*), i8* noundef bitcast (i32* @balancer_max to i8*), i64 noundef 0) #7, !dbg !498
  br label %36, !dbg !500

36:                                               ; preds = %34, %31
  %37 = phi i32* [ @balancer_max, %34 ], [ %29, %31 ], !dbg !465
  call void @llvm.dbg.value(metadata i32* %37, metadata !463, metadata !DIExpression()), !dbg !465
  br i1 %14, label %38, label %77, !dbg !501

38:                                               ; preds = %36
  %39 = load i64, i64* @"llvm.iphdr:0:12$0:9", align 8
  %40 = getelementptr i8, i8* %5, i64 %39
  %41 = bitcast i8* %40 to i32*
  %42 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 20, i32* %41)
  %43 = load i32, i32* %42, align 4, !dbg !502, !tbaa !399
  %44 = call i32 @llvm.bswap.i32(i32 %43), !dbg !505
  call void @llvm.dbg.value(metadata i32 %44, metadata !506, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata i32 0, metadata !511, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata i32 0, metadata !512, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata i32 0, metadata !513, metadata !DIExpression()) #7, !dbg !519
  %45 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.7* @nonce to i8*), i8* noundef bitcast (i32* @zero to i8*)) #7, !dbg !521
  %46 = bitcast i8* %45 to i32*, !dbg !521
  call void @llvm.dbg.value(metadata i32* %46, metadata !518, metadata !DIExpression()) #7, !dbg !519
  %47 = icmp eq i8* %45, null, !dbg !522
  br i1 %47, label %137, label %48, !dbg !524

48:                                               ; preds = %38
  %49 = load i32, i32* %46, align 4, !dbg !525, !tbaa !495
  %50 = icmp eq i32 %49, 0, !dbg !527
  br i1 %50, label %51, label %53, !dbg !528

51:                                               ; preds = %48
  %52 = call i32 inttoptr (i64 7 to i32 ()*)() #7, !dbg !529
  store i32 %52, i32* %46, align 4, !dbg !531, !tbaa !495
  br label %53, !dbg !532

53:                                               ; preds = %51, %48
  %54 = phi i32 [ %52, %51 ], [ %49, %48 ], !dbg !533
  call void @llvm.dbg.value(metadata i32 %54, metadata !517, metadata !DIExpression()) #7, !dbg !519
  %55 = add i32 %54, -559038725, !dbg !534
  call void @llvm.dbg.value(metadata i32 %55, metadata !517, metadata !DIExpression()) #7, !dbg !519
  %56 = add i32 %55, %44, !dbg !535
  call void @llvm.dbg.value(metadata i32 %56, metadata !514, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata i32 %55, metadata !515, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata i32 %55, metadata !516, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata i32 0, metadata !516, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata i32 %55, metadata !536, metadata !DIExpression()) #7, !dbg !542
  call void @llvm.dbg.value(metadata i32 14, metadata !541, metadata !DIExpression()) #7, !dbg !542
  %57 = call i32 @llvm.fshl.i32(i32 %55, i32 %55, i32 14) #7, !dbg !545
  %58 = sub i32 0, %57, !dbg !546
  call void @llvm.dbg.value(metadata i32 %58, metadata !516, metadata !DIExpression()) #7, !dbg !519
  %59 = xor i32 %56, %58, !dbg !546
  call void @llvm.dbg.value(metadata i32 %59, metadata !514, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata i32 %58, metadata !536, metadata !DIExpression()) #7, !dbg !547
  call void @llvm.dbg.value(metadata i32 11, metadata !541, metadata !DIExpression()) #7, !dbg !547
  %60 = call i32 @llvm.fshl.i32(i32 %58, i32 %58, i32 11) #7, !dbg !549
  %61 = sub i32 %59, %60, !dbg !546
  call void @llvm.dbg.value(metadata i32 %61, metadata !514, metadata !DIExpression()) #7, !dbg !519
  %62 = xor i32 %61, %55, !dbg !546
  call void @llvm.dbg.value(metadata i32 %62, metadata !515, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata i32 %61, metadata !536, metadata !DIExpression()) #7, !dbg !550
  call void @llvm.dbg.value(metadata i32 25, metadata !541, metadata !DIExpression()) #7, !dbg !550
  %63 = call i32 @llvm.fshl.i32(i32 %61, i32 %61, i32 25) #7, !dbg !552
  %64 = sub i32 %62, %63, !dbg !546
  call void @llvm.dbg.value(metadata i32 %64, metadata !515, metadata !DIExpression()) #7, !dbg !519
  %65 = xor i32 %64, %58, !dbg !546
  call void @llvm.dbg.value(metadata i32 %65, metadata !516, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata i32 %64, metadata !536, metadata !DIExpression()) #7, !dbg !553
  call void @llvm.dbg.value(metadata i32 16, metadata !541, metadata !DIExpression()) #7, !dbg !553
  %66 = call i32 @llvm.fshl.i32(i32 %64, i32 %64, i32 16) #7, !dbg !555
  %67 = sub i32 %65, %66, !dbg !546
  call void @llvm.dbg.value(metadata i32 %67, metadata !516, metadata !DIExpression()) #7, !dbg !519
  %68 = xor i32 %67, %61, !dbg !546
  call void @llvm.dbg.value(metadata i32 %68, metadata !514, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata i32 %67, metadata !536, metadata !DIExpression()) #7, !dbg !556
  call void @llvm.dbg.value(metadata i32 4, metadata !541, metadata !DIExpression()) #7, !dbg !556
  %69 = call i32 @llvm.fshl.i32(i32 %67, i32 %67, i32 4) #7, !dbg !558
  %70 = sub i32 %68, %69, !dbg !546
  call void @llvm.dbg.value(metadata i32 %70, metadata !514, metadata !DIExpression()) #7, !dbg !519
  %71 = xor i32 %70, %64, !dbg !546
  call void @llvm.dbg.value(metadata i32 %71, metadata !515, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata i32 %70, metadata !536, metadata !DIExpression()) #7, !dbg !559
  call void @llvm.dbg.value(metadata i32 14, metadata !541, metadata !DIExpression()) #7, !dbg !559
  %72 = call i32 @llvm.fshl.i32(i32 %70, i32 %70, i32 14) #7, !dbg !561
  %73 = sub i32 %71, %72, !dbg !546
  call void @llvm.dbg.value(metadata i32 %73, metadata !515, metadata !DIExpression()) #7, !dbg !519
  %74 = xor i32 %73, %67, !dbg !546
  call void @llvm.dbg.value(metadata i32 %74, metadata !516, metadata !DIExpression()) #7, !dbg !519
  call void @llvm.dbg.value(metadata i32 %73, metadata !536, metadata !DIExpression()) #7, !dbg !562
  call void @llvm.dbg.value(metadata i32 24, metadata !541, metadata !DIExpression()) #7, !dbg !562
  %75 = call i32 @llvm.fshl.i32(i32 %73, i32 %73, i32 24) #7, !dbg !564
  %76 = sub i32 %74, %75, !dbg !546
  call void @llvm.dbg.value(metadata i32 %76, metadata !516, metadata !DIExpression()) #7, !dbg !519
  br label %137, !dbg !565

77:                                               ; preds = %36
  %78 = load i64, i64* @"llvm.ipv6hdr:0:8$0:6:0:2:0", align 8
  %79 = getelementptr i8, i8* %6, i64 %78
  %80 = bitcast i8* %79 to i32*
  %81 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 21, i32* %80)
  %82 = load i32, i32* %81, align 4, !dbg !566, !tbaa !415
  %83 = call i32 @llvm.bswap.i32(i32 %82), !dbg !568
  %84 = load i64, i64* @"llvm.ipv6hdr:0:12$0:6:0:2:1", align 8
  %85 = getelementptr i8, i8* %6, i64 %84
  %86 = bitcast i8* %85 to i32*
  %87 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 22, i32* %86)
  %88 = load i32, i32* %87, align 4, !dbg !569, !tbaa !415
  %89 = call i32 @llvm.bswap.i32(i32 %88), !dbg !570
  %90 = load i64, i64* @"llvm.ipv6hdr:0:16$0:6:0:2:2", align 8
  %91 = getelementptr i8, i8* %6, i64 %90
  %92 = bitcast i8* %91 to i32*
  %93 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 23, i32* %92)
  %94 = load i32, i32* %93, align 4, !dbg !571, !tbaa !415
  %95 = call i32 @llvm.bswap.i32(i32 %94), !dbg !572
  %96 = load i64, i64* @"llvm.ipv6hdr:0:20$0:6:0:2:3", align 8
  %97 = getelementptr i8, i8* %6, i64 %96
  %98 = bitcast i8* %97 to i32*
  %99 = call i32* @llvm.bpf.passthrough.p0i32.p0i32(i32 24, i32* %98)
  %100 = load i32, i32* %99, align 4, !dbg !573, !tbaa !415
  %101 = call i32 @llvm.bswap.i32(i32 %100), !dbg !574
  call void @llvm.dbg.value(metadata i32 %83, metadata !506, metadata !DIExpression()) #7, !dbg !575
  call void @llvm.dbg.value(metadata i32 %89, metadata !511, metadata !DIExpression()) #7, !dbg !575
  call void @llvm.dbg.value(metadata i32 %95, metadata !512, metadata !DIExpression()) #7, !dbg !575
  call void @llvm.dbg.value(metadata i32 %101, metadata !513, metadata !DIExpression()) #7, !dbg !575
  %102 = call i8* inttoptr (i64 1 to i8* (i8*, i8*)*)(i8* noundef bitcast (%struct.anon.7* @nonce to i8*), i8* noundef bitcast (i32* @zero to i8*)) #7, !dbg !577
  %103 = bitcast i8* %102 to i32*, !dbg !577
  call void @llvm.dbg.value(metadata i32* %103, metadata !518, metadata !DIExpression()) #7, !dbg !575
  %104 = icmp eq i8* %102, null, !dbg !578
  br i1 %104, label %137, label %105, !dbg !579

105:                                              ; preds = %77
  %106 = load i32, i32* %103, align 4, !dbg !580, !tbaa !495
  %107 = icmp eq i32 %106, 0, !dbg !581
  br i1 %107, label %108, label %110, !dbg !582

108:                                              ; preds = %105
  %109 = call i32 inttoptr (i64 7 to i32 ()*)() #7, !dbg !583
  store i32 %109, i32* %103, align 4, !dbg !584, !tbaa !495
  br label %110, !dbg !585

110:                                              ; preds = %108, %105
  %111 = phi i32 [ %109, %108 ], [ %106, %105 ], !dbg !586
  call void @llvm.dbg.value(metadata i32 %111, metadata !517, metadata !DIExpression()) #7, !dbg !575
  %112 = add i32 %111, -559038725, !dbg !587
  call void @llvm.dbg.value(metadata i32 %112, metadata !517, metadata !DIExpression()) #7, !dbg !575
  %113 = add i32 %89, %83, !dbg !588
  %114 = add i32 %113, %95, !dbg !589
  %115 = add i32 %114, %101, !dbg !590
  %116 = add i32 %115, %112, !dbg !591
  call void @llvm.dbg.value(metadata i32 %116, metadata !514, metadata !DIExpression()) #7, !dbg !575
  call void @llvm.dbg.value(metadata i32 %112, metadata !515, metadata !DIExpression()) #7, !dbg !575
  call void @llvm.dbg.value(metadata i32 %112, metadata !516, metadata !DIExpression()) #7, !dbg !575
  call void @llvm.dbg.value(metadata i32 0, metadata !516, metadata !DIExpression()) #7, !dbg !575
  call void @llvm.dbg.value(metadata i32 %112, metadata !536, metadata !DIExpression()) #7, !dbg !592
  call void @llvm.dbg.value(metadata i32 14, metadata !541, metadata !DIExpression()) #7, !dbg !592
  %117 = call i32 @llvm.fshl.i32(i32 %112, i32 %112, i32 14) #7, !dbg !594
  %118 = sub i32 0, %117, !dbg !595
  call void @llvm.dbg.value(metadata i32 %118, metadata !516, metadata !DIExpression()) #7, !dbg !575
  %119 = xor i32 %116, %118, !dbg !595
  call void @llvm.dbg.value(metadata i32 %119, metadata !514, metadata !DIExpression()) #7, !dbg !575
  call void @llvm.dbg.value(metadata i32 %118, metadata !536, metadata !DIExpression()) #7, !dbg !596
  call void @llvm.dbg.value(metadata i32 11, metadata !541, metadata !DIExpression()) #7, !dbg !596
  %120 = call i32 @llvm.fshl.i32(i32 %118, i32 %118, i32 11) #7, !dbg !598
  %121 = sub i32 %119, %120, !dbg !595
  call void @llvm.dbg.value(metadata i32 %121, metadata !514, metadata !DIExpression()) #7, !dbg !575
  %122 = xor i32 %121, %112, !dbg !595
  call void @llvm.dbg.value(metadata i32 %122, metadata !515, metadata !DIExpression()) #7, !dbg !575
  call void @llvm.dbg.value(metadata i32 %121, metadata !536, metadata !DIExpression()) #7, !dbg !599
  call void @llvm.dbg.value(metadata i32 25, metadata !541, metadata !DIExpression()) #7, !dbg !599
  %123 = call i32 @llvm.fshl.i32(i32 %121, i32 %121, i32 25) #7, !dbg !601
  %124 = sub i32 %122, %123, !dbg !595
  call void @llvm.dbg.value(metadata i32 %124, metadata !515, metadata !DIExpression()) #7, !dbg !575
  %125 = xor i32 %124, %118, !dbg !595
  call void @llvm.dbg.value(metadata i32 %125, metadata !516, metadata !DIExpression()) #7, !dbg !575
  call void @llvm.dbg.value(metadata i32 %124, metadata !536, metadata !DIExpression()) #7, !dbg !602
  call void @llvm.dbg.value(metadata i32 16, metadata !541, metadata !DIExpression()) #7, !dbg !602
  %126 = call i32 @llvm.fshl.i32(i32 %124, i32 %124, i32 16) #7, !dbg !604
  %127 = sub i32 %125, %126, !dbg !595
  call void @llvm.dbg.value(metadata i32 %127, metadata !516, metadata !DIExpression()) #7, !dbg !575
  %128 = xor i32 %127, %121, !dbg !595
  call void @llvm.dbg.value(metadata i32 %128, metadata !514, metadata !DIExpression()) #7, !dbg !575
  call void @llvm.dbg.value(metadata i32 %127, metadata !536, metadata !DIExpression()) #7, !dbg !605
  call void @llvm.dbg.value(metadata i32 4, metadata !541, metadata !DIExpression()) #7, !dbg !605
  %129 = call i32 @llvm.fshl.i32(i32 %127, i32 %127, i32 4) #7, !dbg !607
  %130 = sub i32 %128, %129, !dbg !595
  call void @llvm.dbg.value(metadata i32 %130, metadata !514, metadata !DIExpression()) #7, !dbg !575
  %131 = xor i32 %130, %124, !dbg !595
  call void @llvm.dbg.value(metadata i32 %131, metadata !515, metadata !DIExpression()) #7, !dbg !575
  call void @llvm.dbg.value(metadata i32 %130, metadata !536, metadata !DIExpression()) #7, !dbg !608
  call void @llvm.dbg.value(metadata i32 14, metadata !541, metadata !DIExpression()) #7, !dbg !608
  %132 = call i32 @llvm.fshl.i32(i32 %130, i32 %130, i32 14) #7, !dbg !610
  %133 = sub i32 %131, %132, !dbg !595
  call void @llvm.dbg.value(metadata i32 %133, metadata !515, metadata !DIExpression()) #7, !dbg !575
  %134 = xor i32 %133, %127, !dbg !595
  call void @llvm.dbg.value(metadata i32 %134, metadata !516, metadata !DIExpression()) #7, !dbg !575
  call void @llvm.dbg.value(metadata i32 %133, metadata !536, metadata !DIExpression()) #7, !dbg !611
  call void @llvm.dbg.value(metadata i32 24, metadata !541, metadata !DIExpression()) #7, !dbg !611
  %135 = call i32 @llvm.fshl.i32(i32 %133, i32 %133, i32 24) #7, !dbg !613
  %136 = sub i32 %134, %135, !dbg !595
  call void @llvm.dbg.value(metadata i32 %136, metadata !516, metadata !DIExpression()) #7, !dbg !575
  br label %137, !dbg !614

137:                                              ; preds = %110, %77, %53, %38
  %138 = phi i32 [ %76, %53 ], [ 0, %38 ], [ %136, %110 ], [ 0, %77 ]
  %139 = load i32, i32* %37, align 4, !dbg !615, !tbaa !495
  %140 = urem i32 %138, %139, !dbg !615
  store i32 %140, i32* %4, align 4, !dbg !615, !tbaa !495
  call void @llvm.dbg.value(metadata i32* %4, metadata !460, metadata !DIExpression(DW_OP_deref)), !dbg !465
  %141 = call i64 inttoptr (i64 82 to i64 (%struct.sk_reuseport_md*, i8*, i8*, i64)*)(%struct.sk_reuseport_md* noundef %0, i8* noundef %22, i8* noundef nonnull %7, i64 noundef 0) #7, !dbg !616
  %142 = icmp eq i64 %141, 0, !dbg !618
  %143 = zext i1 %142 to i32
  call void @llvm.dbg.value(metadata i32 %143, metadata !457, metadata !DIExpression()), !dbg !465
  br label %144

144:                                              ; preds = %1, %137
  %145 = phi i32 [ %143, %137 ], [ 0, %1 ], !dbg !465
  call void @llvm.lifetime.end.p0i8(i64 4, i8* nonnull %7) #7, !dbg !619
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %6) #7, !dbg !619
  call void @llvm.lifetime.end.p0i8(i64 20, i8* nonnull %5) #7, !dbg !619
  ret i32 %145, !dbg !619
}

; Function Attrs: argmemonly mustprogress nofree nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #4

; Function Attrs: mustprogress nofree nosync nounwind readnone speculatable willreturn
declare i32 @llvm.bswap.i32(i32) #2

; Function Attrs: nofree nosync nounwind readnone
declare i32* @llvm.bpf.passthrough.p0i32.p0i32(i32, i32*) #5

; Function Attrs: nofree nosync nounwind readnone
declare i16* @llvm.bpf.passthrough.p0i16.p0i16(i32, i16*) #5

; Function Attrs: nofree nosync nounwind readnone
declare i8* @llvm.bpf.passthrough.p0i8.p0i8(i32, i8*) #5

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
!llvm.module.flags = !{!341, !342, !343, !344}
!llvm.ident = !{!345}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "zero", scope: !2, file: !3, line: 26, type: !77, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "Ubuntu clang version 14.0.0-1ubuntu1", isOptimized: true, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !58, globals: !74, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "buzz_lb_kern.c", directory: "/media/aadhitya/DATA/XCodes/buzzLB/src", checksumkind: CSK_MD5, checksum: "43050237e601e4109b67833a021c1cf0")
!4 = !{!5, !14, !44, !48, !52}
!5 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "xdp_action", file: !6, line: 42776, baseType: !7, size: 32, elements: !8)
!6 = !DIFile(filename: "./vmlinux.h", directory: "/media/aadhitya/DATA/XCodes/buzzLB/src", checksumkind: CSK_MD5, checksum: "11eb692ee35903a9cd527ec4f7485b7b")
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !{!9, !10, !11, !12, !13}
!9 = !DIEnumerator(name: "XDP_ABORTED", value: 0)
!10 = !DIEnumerator(name: "XDP_DROP", value: 1)
!11 = !DIEnumerator(name: "XDP_PASS", value: 2)
!12 = !DIEnumerator(name: "XDP_TX", value: 3)
!13 = !DIEnumerator(name: "XDP_REDIRECT", value: 4)
!14 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 11396, baseType: !7, size: 32, elements: !15)
!15 = !{!16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38, !39, !40, !41, !42, !43}
!16 = !DIEnumerator(name: "IPPROTO_IP", value: 0)
!17 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1)
!18 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2)
!19 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4)
!20 = !DIEnumerator(name: "IPPROTO_TCP", value: 6)
!21 = !DIEnumerator(name: "IPPROTO_EGP", value: 8)
!22 = !DIEnumerator(name: "IPPROTO_PUP", value: 12)
!23 = !DIEnumerator(name: "IPPROTO_UDP", value: 17)
!24 = !DIEnumerator(name: "IPPROTO_IDP", value: 22)
!25 = !DIEnumerator(name: "IPPROTO_TP", value: 29)
!26 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33)
!27 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41)
!28 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46)
!29 = !DIEnumerator(name: "IPPROTO_GRE", value: 47)
!30 = !DIEnumerator(name: "IPPROTO_ESP", value: 50)
!31 = !DIEnumerator(name: "IPPROTO_AH", value: 51)
!32 = !DIEnumerator(name: "IPPROTO_MTP", value: 92)
!33 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94)
!34 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98)
!35 = !DIEnumerator(name: "IPPROTO_PIM", value: 103)
!36 = !DIEnumerator(name: "IPPROTO_COMP", value: 108)
!37 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132)
!38 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136)
!39 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137)
!40 = !DIEnumerator(name: "IPPROTO_ETHERNET", value: 143)
!41 = !DIEnumerator(name: "IPPROTO_RAW", value: 255)
!42 = !DIEnumerator(name: "IPPROTO_MPTCP", value: 262)
!43 = !DIEnumerator(name: "IPPROTO_MAX", value: 263)
!44 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "sk_action", file: !6, line: 43317, baseType: !7, size: 32, elements: !45)
!45 = !{!46, !47}
!46 = !DIEnumerator(name: "SK_DROP", value: 0)
!47 = !DIEnumerator(name: "SK_PASS", value: 1)
!48 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "bpf_hdr_start_off", file: !6, line: 122169, baseType: !7, size: 32, elements: !49)
!49 = !{!50, !51}
!50 = !DIEnumerator(name: "BPF_HDR_START_MAC", value: 0)
!51 = !DIEnumerator(name: "BPF_HDR_START_NET", value: 1)
!52 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !6, line: 43553, baseType: !7, size: 32, elements: !53)
!53 = !{!54, !55, !56, !57}
!54 = !DIEnumerator(name: "BPF_ANY", value: 0)
!55 = !DIEnumerator(name: "BPF_NOEXIST", value: 1)
!56 = !DIEnumerator(name: "BPF_EXIST", value: 2)
!57 = !DIEnumerator(name: "BPF_F_LOCK", value: 4)
!58 = !{!59, !60, !61, !7, !63, !65, !66, !70}
!59 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!60 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!61 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !6, line: 10, baseType: !62)
!62 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!63 = !DIDerivedType(tag: DW_TAG_typedef, name: "u32", file: !6, line: 409, baseType: !64)
!64 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !6, line: 12, baseType: !7)
!65 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!66 = !DICompositeType(tag: DW_TAG_array_type, baseType: !67, size: 48, elements: !68)
!67 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!68 = !{!69}
!69 = !DISubrange(count: 6)
!70 = !DICompositeType(tag: DW_TAG_array_type, baseType: !71, size: 128, elements: !72)
!71 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be32", file: !6, line: 7174, baseType: !64)
!72 = !{!73}
!73 = !DISubrange(count: 4)
!74 = !{!0, !75, !78, !136, !141, !146, !148, !151, !169, !178, !198, !207, !218, !225, !230, !235, !244, !251, !256, !261, !266}
!75 = !DIGlobalVariableExpression(var: !76, expr: !DIExpression())
!76 = distinct !DIGlobalVariable(name: "balancer_max", scope: !2, file: !3, line: 27, type: !77, isLocal: false, isDefinition: true)
!77 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !63)
!78 = !DIGlobalVariableExpression(var: !79, expr: !DIExpression())
!79 = distinct !DIGlobalVariable(name: "____fmt", scope: !80, file: !3, line: 150, type: !132, isLocal: true, isDefinition: true)
!80 = distinct !DISubprogram(name: "buzz_lb_xdp", scope: !3, file: !3, line: 146, type: !81, scopeLine: 146, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !93)
!81 = !DISubroutineType(types: !82)
!82 = !{!83, !84}
!83 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!84 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !85, size: 64)
!85 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "xdp_md", file: !6, line: 46155, size: 192, elements: !86)
!86 = !{!87, !88, !89, !90, !91, !92}
!87 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !85, file: !6, line: 46156, baseType: !64, size: 32)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !85, file: !6, line: 46157, baseType: !64, size: 32, offset: 32)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "data_meta", scope: !85, file: !6, line: 46158, baseType: !64, size: 32, offset: 64)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "ingress_ifindex", scope: !85, file: !6, line: 46159, baseType: !64, size: 32, offset: 96)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_index", scope: !85, file: !6, line: 46160, baseType: !64, size: 32, offset: 128)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "egress_ifindex", scope: !85, file: !6, line: 46161, baseType: !64, size: 32, offset: 160)
!93 = !{!94, !95, !96, !97, !102, !103, !111, !128}
!94 = !DILocalVariable(name: "ctx", arg: 1, scope: !80, file: !3, line: 146, type: !84)
!95 = !DILocalVariable(name: "data", scope: !80, file: !3, line: 147, type: !59)
!96 = !DILocalVariable(name: "data_end", scope: !80, file: !3, line: 148, type: !59)
!97 = !DILocalVariable(name: "trace", scope: !80, file: !3, line: 152, type: !98)
!98 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "S", file: !3, line: 93, size: 64, elements: !99)
!99 = !{!100}
!100 = !DIDerivedType(tag: DW_TAG_member, name: "time", scope: !98, file: !3, line: 95, baseType: !101, size: 64)
!101 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!102 = !DILocalVariable(name: "ret", scope: !80, file: !3, line: 153, type: !83)
!103 = !DILocalVariable(name: "eth", scope: !80, file: !3, line: 159, type: !104)
!104 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !105, size: 64)
!105 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ethhdr", file: !6, line: 63925, size: 112, elements: !106)
!106 = !{!107, !108, !109}
!107 = !DIDerivedType(tag: DW_TAG_member, name: "h_dest", scope: !105, file: !6, line: 63926, baseType: !66, size: 48)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "h_source", scope: !105, file: !6, line: 63927, baseType: !66, size: 48, offset: 48)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "h_proto", scope: !105, file: !6, line: 63928, baseType: !110, size: 16, offset: 96)
!110 = !DIDerivedType(tag: DW_TAG_typedef, name: "__be16", file: !6, line: 7170, baseType: !61)
!111 = !DILocalVariable(name: "iph", scope: !80, file: !3, line: 166, type: !112)
!112 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !113, size: 64)
!113 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "iphdr", file: !6, line: 66181, size: 160, elements: !114)
!114 = !{!115, !117, !118, !119, !120, !121, !122, !123, !124, !126, !127}
!115 = !DIDerivedType(tag: DW_TAG_member, name: "ihl", scope: !113, file: !6, line: 66182, baseType: !116, size: 4, flags: DIFlagBitField, extraData: i64 0)
!116 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !6, line: 8, baseType: !67)
!117 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !113, file: !6, line: 66183, baseType: !116, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!118 = !DIDerivedType(tag: DW_TAG_member, name: "tos", scope: !113, file: !6, line: 66184, baseType: !116, size: 8, offset: 8)
!119 = !DIDerivedType(tag: DW_TAG_member, name: "tot_len", scope: !113, file: !6, line: 66185, baseType: !110, size: 16, offset: 16)
!120 = !DIDerivedType(tag: DW_TAG_member, name: "id", scope: !113, file: !6, line: 66186, baseType: !110, size: 16, offset: 32)
!121 = !DIDerivedType(tag: DW_TAG_member, name: "frag_off", scope: !113, file: !6, line: 66187, baseType: !110, size: 16, offset: 48)
!122 = !DIDerivedType(tag: DW_TAG_member, name: "ttl", scope: !113, file: !6, line: 66188, baseType: !116, size: 8, offset: 64)
!123 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !113, file: !6, line: 66189, baseType: !116, size: 8, offset: 72)
!124 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !113, file: !6, line: 66190, baseType: !125, size: 16, offset: 80)
!125 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sum16", file: !6, line: 65086, baseType: !61)
!126 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !113, file: !6, line: 66191, baseType: !71, size: 32, offset: 96)
!127 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !113, file: !6, line: 66192, baseType: !71, size: 32, offset: 128)
!128 = !DILocalVariable(name: "be", scope: !129, file: !3, line: 177, type: !131)
!129 = distinct !DILexicalBlock(scope: !130, file: !3, line: 176, column: 5)
!130 = distinct !DILexicalBlock(scope: !80, file: !3, line: 175, column: 9)
!131 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!132 = !DICompositeType(tag: DW_TAG_array_type, baseType: !133, size: 184, elements: !134)
!133 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !131)
!134 = !{!135}
!135 = !DISubrange(count: 23)
!136 = !DIGlobalVariableExpression(var: !137, expr: !DIExpression())
!137 = distinct !DIGlobalVariable(name: "____fmt", scope: !80, file: !3, line: 157, type: !138, isLocal: true, isDefinition: true)
!138 = !DICompositeType(tag: DW_TAG_array_type, baseType: !133, size: 240, elements: !139)
!139 = !{!140}
!140 = !DISubrange(count: 30)
!141 = !DIGlobalVariableExpression(var: !142, expr: !DIExpression())
!142 = distinct !DIGlobalVariable(name: "____fmt", scope: !80, file: !3, line: 171, type: !143, isLocal: true, isDefinition: true)
!143 = !DICompositeType(tag: DW_TAG_array_type, baseType: !133, size: 216, elements: !144)
!144 = !{!145}
!145 = !DISubrange(count: 27)
!146 = !DIGlobalVariableExpression(var: !147, expr: !DIExpression())
!147 = distinct !DIGlobalVariable(name: "____fmt", scope: !80, file: !3, line: 173, type: !132, isLocal: true, isDefinition: true)
!148 = !DIGlobalVariableExpression(var: !149, expr: !DIExpression())
!149 = distinct !DIGlobalVariable(name: "_license", scope: !2, file: !3, line: 278, type: !150, isLocal: false, isDefinition: true)
!150 = !DICompositeType(tag: DW_TAG_array_type, baseType: !131, size: 32, elements: !72)
!151 = !DIGlobalVariableExpression(var: !152, expr: !DIExpression())
!152 = distinct !DIGlobalVariable(name: "nonce", scope: !2, file: !3, line: 37, type: !153, isLocal: false, isDefinition: true)
!153 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 31, size: 320, elements: !154)
!154 = !{!155, !160, !162, !163, !168}
!155 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !153, file: !3, line: 32, baseType: !156, size: 64)
!156 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !157, size: 64)
!157 = !DICompositeType(tag: DW_TAG_array_type, baseType: !83, size: 64, elements: !158)
!158 = !{!159}
!159 = !DISubrange(count: 2)
!160 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !153, file: !3, line: 33, baseType: !161, size: 64, offset: 64)
!161 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !63, size: 64)
!162 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !153, file: !3, line: 34, baseType: !161, size: 64, offset: 128)
!163 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !153, file: !3, line: 35, baseType: !164, size: 64, offset: 192)
!164 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !165, size: 64)
!165 = !DICompositeType(tag: DW_TAG_array_type, baseType: !83, size: 32, elements: !166)
!166 = !{!167}
!167 = !DISubrange(count: 1)
!168 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !153, file: !3, line: 36, baseType: !164, size: 64, offset: 256)
!169 = !DIGlobalVariableExpression(var: !170, expr: !DIExpression())
!170 = distinct !DIGlobalVariable(name: "size", scope: !2, file: !3, line: 45, type: !171, isLocal: false, isDefinition: true)
!171 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 39, size: 320, elements: !172)
!172 = !{!173, !174, !175, !176, !177}
!173 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !171, file: !3, line: 40, baseType: !156, size: 64)
!174 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !171, file: !3, line: 41, baseType: !161, size: 64, offset: 64)
!175 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !171, file: !3, line: 42, baseType: !161, size: 64, offset: 128)
!176 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !171, file: !3, line: 43, baseType: !164, size: 64, offset: 192)
!177 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !171, file: !3, line: 44, baseType: !164, size: 64, offset: 256)
!178 = !DIGlobalVariableExpression(var: !179, expr: !DIExpression())
!179 = distinct !DIGlobalVariable(name: "tcp_balancing_targets", scope: !2, file: !3, line: 53, type: !180, isLocal: false, isDefinition: true)
!180 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 47, size: 320, elements: !181)
!181 = !{!182, !187, !188, !192, !197}
!182 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !180, file: !3, line: 48, baseType: !183, size: 64)
!183 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !184, size: 64)
!184 = !DICompositeType(tag: DW_TAG_array_type, baseType: !83, size: 640, elements: !185)
!185 = !{!186}
!186 = !DISubrange(count: 20)
!187 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !180, file: !3, line: 49, baseType: !161, size: 64, offset: 64)
!188 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !180, file: !3, line: 50, baseType: !189, size: 64, offset: 128)
!189 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !190, size: 64)
!190 = !DIDerivedType(tag: DW_TAG_typedef, name: "u64", file: !6, line: 18, baseType: !191)
!191 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u64", file: !6, line: 16, baseType: !101)
!192 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !180, file: !3, line: 51, baseType: !193, size: 64, offset: 192)
!193 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !194, size: 64)
!194 = !DICompositeType(tag: DW_TAG_array_type, baseType: !83, size: 4096, elements: !195)
!195 = !{!196}
!196 = !DISubrange(count: 128)
!197 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !180, file: !3, line: 52, baseType: !164, size: 64, offset: 256)
!198 = !DIGlobalVariableExpression(var: !199, expr: !DIExpression())
!199 = distinct !DIGlobalVariable(name: "udp_balancing_targets", scope: !2, file: !3, line: 61, type: !200, isLocal: false, isDefinition: true)
!200 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 55, size: 320, elements: !201)
!201 = !{!202, !203, !204, !205, !206}
!202 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !200, file: !3, line: 56, baseType: !183, size: 64)
!203 = !DIDerivedType(tag: DW_TAG_member, name: "key", scope: !200, file: !3, line: 57, baseType: !161, size: 64, offset: 64)
!204 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !200, file: !3, line: 58, baseType: !189, size: 64, offset: 128)
!205 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !200, file: !3, line: 59, baseType: !193, size: 64, offset: 192)
!206 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !200, file: !3, line: 60, baseType: !164, size: 64, offset: 256)
!207 = !DIGlobalVariableExpression(var: !208, expr: !DIExpression())
!208 = distinct !DIGlobalVariable(name: "perf_map", scope: !2, file: !3, line: 69, type: !209, isLocal: false, isDefinition: true)
!209 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !3, line: 63, size: 320, elements: !210)
!210 = !{!211, !214, !215, !216, !217}
!211 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !209, file: !3, line: 64, baseType: !212, size: 64)
!212 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !213, size: 64)
!213 = !DICompositeType(tag: DW_TAG_array_type, baseType: !83, size: 128, elements: !72)
!214 = !DIDerivedType(tag: DW_TAG_member, name: "key_size", scope: !209, file: !3, line: 65, baseType: !212, size: 64, offset: 64)
!215 = !DIDerivedType(tag: DW_TAG_member, name: "value_size", scope: !209, file: !3, line: 66, baseType: !212, size: 64, offset: 128)
!216 = !DIDerivedType(tag: DW_TAG_member, name: "max_entries", scope: !209, file: !3, line: 67, baseType: !193, size: 64, offset: 192)
!217 = !DIDerivedType(tag: DW_TAG_member, name: "pinning", scope: !209, file: !3, line: 68, baseType: !164, size: 64, offset: 256)
!218 = !DIGlobalVariableExpression(var: !219, expr: !DIExpression())
!219 = distinct !DIGlobalVariable(name: "bpf_trace_printk", scope: !2, file: !220, line: 177, type: !221, isLocal: true, isDefinition: true)
!220 = !DIFile(filename: "./../libbpf/src/bpf_helper_defs.h", directory: "/media/aadhitya/DATA/XCodes/buzzLB/src", checksumkind: CSK_MD5, checksum: "2d210aba22162d34a56b8d1dc5e331a2")
!221 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !222, size: 64)
!222 = !DISubroutineType(types: !223)
!223 = !{!60, !224, !64, null}
!224 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !133, size: 64)
!225 = !DIGlobalVariableExpression(var: !226, expr: !DIExpression())
!226 = distinct !DIGlobalVariable(name: "bpf_ktime_get_ns", scope: !2, file: !220, line: 114, type: !227, isLocal: true, isDefinition: true)
!227 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !228, size: 64)
!228 = !DISubroutineType(types: !229)
!229 = !{!191}
!230 = !DIGlobalVariableExpression(var: !231, expr: !DIExpression())
!231 = distinct !DIGlobalVariable(name: "bpf_perf_event_output", scope: !2, file: !220, line: 696, type: !232, isLocal: true, isDefinition: true)
!232 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !233, size: 64)
!233 = !DISubroutineType(types: !234)
!234 = !{!60, !59, !59, !191, !59, !191}
!235 = !DIGlobalVariableExpression(var: !236, expr: !DIExpression())
!236 = distinct !DIGlobalVariable(name: "bpf_csum_diff", scope: !2, file: !220, line: 794, type: !237, isLocal: true, isDefinition: true)
!237 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !238, size: 64)
!238 = !DISubroutineType(types: !239)
!239 = !{!240, !242, !64, !242, !64, !243}
!240 = !DIDerivedType(tag: DW_TAG_typedef, name: "__s64", file: !6, line: 14, baseType: !241)
!241 = !DIBasicType(name: "long long", size: 64, encoding: DW_ATE_signed)
!242 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64)
!243 = !DIDerivedType(tag: DW_TAG_typedef, name: "__wsum", file: !6, line: 7176, baseType: !64)
!244 = !DIGlobalVariableExpression(var: !245, expr: !DIExpression())
!245 = distinct !DIGlobalVariable(name: "bpf_skb_load_bytes_relative", scope: !2, file: !220, line: 1813, type: !246, isLocal: true, isDefinition: true)
!246 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !247, size: 64)
!247 = !DISubroutineType(types: !248)
!248 = !{!60, !249, !64, !59, !64, !64}
!249 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !250, size: 64)
!250 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!251 = !DIGlobalVariableExpression(var: !252, expr: !DIExpression())
!252 = distinct !DIGlobalVariable(name: "bpf_map_lookup_elem", scope: !2, file: !220, line: 56, type: !253, isLocal: true, isDefinition: true)
!253 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !254, size: 64)
!254 = !DISubroutineType(types: !255)
!255 = !{!59, !59, !249}
!256 = !DIGlobalVariableExpression(var: !257, expr: !DIExpression())
!257 = distinct !DIGlobalVariable(name: "bpf_map_update_elem", scope: !2, file: !220, line: 78, type: !258, isLocal: true, isDefinition: true)
!258 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !259, size: 64)
!259 = !DISubroutineType(types: !260)
!260 = !{!60, !59, !249, !249, !191}
!261 = !DIGlobalVariableExpression(var: !262, expr: !DIExpression())
!262 = distinct !DIGlobalVariable(name: "bpf_get_prandom_u32", scope: !2, file: !220, line: 193, type: !263, isLocal: true, isDefinition: true)
!263 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !264, size: 64)
!264 = !DISubroutineType(types: !265)
!265 = !{!64}
!266 = !DIGlobalVariableExpression(var: !267, expr: !DIExpression())
!267 = distinct !DIGlobalVariable(name: "bpf_sk_select_reuseport", scope: !2, file: !220, line: 2148, type: !268, isLocal: true, isDefinition: true)
!268 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !269, size: 64)
!269 = !DISubroutineType(types: !270)
!270 = !{!60, !271, !59, !59, !191}
!271 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !272, size: 64)
!272 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "sk_reuseport_md", file: !6, line: 46184, size: 448, elements: !273)
!273 = !{!274, !278, !282, !283, !284, !285, !286, !287, !310}
!274 = !DIDerivedType(tag: DW_TAG_member, scope: !272, file: !6, line: 46185, baseType: !275, size: 64)
!275 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !272, file: !6, line: 46185, size: 64, elements: !276)
!276 = !{!277}
!277 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !275, file: !6, line: 46186, baseType: !59, size: 64)
!278 = !DIDerivedType(tag: DW_TAG_member, scope: !272, file: !6, line: 46188, baseType: !279, size: 64, offset: 64)
!279 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !272, file: !6, line: 46188, size: 64, elements: !280)
!280 = !{!281}
!281 = !DIDerivedType(tag: DW_TAG_member, name: "data_end", scope: !279, file: !6, line: 46189, baseType: !59, size: 64)
!282 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !272, file: !6, line: 46191, baseType: !64, size: 32, offset: 128)
!283 = !DIDerivedType(tag: DW_TAG_member, name: "eth_protocol", scope: !272, file: !6, line: 46192, baseType: !64, size: 32, offset: 160)
!284 = !DIDerivedType(tag: DW_TAG_member, name: "ip_protocol", scope: !272, file: !6, line: 46193, baseType: !64, size: 32, offset: 192)
!285 = !DIDerivedType(tag: DW_TAG_member, name: "bind_inany", scope: !272, file: !6, line: 46194, baseType: !64, size: 32, offset: 224)
!286 = !DIDerivedType(tag: DW_TAG_member, name: "hash", scope: !272, file: !6, line: 46195, baseType: !64, size: 32, offset: 256)
!287 = !DIDerivedType(tag: DW_TAG_member, scope: !272, file: !6, line: 46196, baseType: !288, size: 64, offset: 320)
!288 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !272, file: !6, line: 46196, size: 64, elements: !289)
!289 = !{!290}
!290 = !DIDerivedType(tag: DW_TAG_member, name: "sk", scope: !288, file: !6, line: 46197, baseType: !291, size: 64)
!291 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !292, size: 64)
!292 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bpf_sock", file: !6, line: 46097, size: 640, elements: !293)
!293 = !{!294, !295, !296, !297, !298, !299, !300, !301, !303, !304, !305, !306, !307, !308}
!294 = !DIDerivedType(tag: DW_TAG_member, name: "bound_dev_if", scope: !292, file: !6, line: 46098, baseType: !64, size: 32)
!295 = !DIDerivedType(tag: DW_TAG_member, name: "family", scope: !292, file: !6, line: 46099, baseType: !64, size: 32, offset: 32)
!296 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !292, file: !6, line: 46100, baseType: !64, size: 32, offset: 64)
!297 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !292, file: !6, line: 46101, baseType: !64, size: 32, offset: 96)
!298 = !DIDerivedType(tag: DW_TAG_member, name: "mark", scope: !292, file: !6, line: 46102, baseType: !64, size: 32, offset: 128)
!299 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !292, file: !6, line: 46103, baseType: !64, size: 32, offset: 160)
!300 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip4", scope: !292, file: !6, line: 46104, baseType: !64, size: 32, offset: 192)
!301 = !DIDerivedType(tag: DW_TAG_member, name: "src_ip6", scope: !292, file: !6, line: 46105, baseType: !302, size: 128, offset: 224)
!302 = !DICompositeType(tag: DW_TAG_array_type, baseType: !64, size: 128, elements: !72)
!303 = !DIDerivedType(tag: DW_TAG_member, name: "src_port", scope: !292, file: !6, line: 46106, baseType: !64, size: 32, offset: 352)
!304 = !DIDerivedType(tag: DW_TAG_member, name: "dst_port", scope: !292, file: !6, line: 46107, baseType: !110, size: 16, offset: 384)
!305 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip4", scope: !292, file: !6, line: 46108, baseType: !64, size: 32, offset: 416)
!306 = !DIDerivedType(tag: DW_TAG_member, name: "dst_ip6", scope: !292, file: !6, line: 46109, baseType: !302, size: 128, offset: 448)
!307 = !DIDerivedType(tag: DW_TAG_member, name: "state", scope: !292, file: !6, line: 46110, baseType: !64, size: 32, offset: 576)
!308 = !DIDerivedType(tag: DW_TAG_member, name: "rx_queue_mapping", scope: !292, file: !6, line: 46111, baseType: !309, size: 32, offset: 608)
!309 = !DIDerivedType(tag: DW_TAG_typedef, name: "__s32", file: !6, line: 401, baseType: !83)
!310 = !DIDerivedType(tag: DW_TAG_member, scope: !272, file: !6, line: 46199, baseType: !311, size: 64, offset: 384)
!311 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !272, file: !6, line: 46199, size: 64, elements: !312)
!312 = !{!313}
!313 = !DIDerivedType(tag: DW_TAG_member, name: "migrating_sk", scope: !311, file: !6, line: 46200, baseType: !291, size: 64)
!314 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ipv6hdr", file: !6, line: 66207, size: 320, elements: !315)
!315 = !{!316, !317, !318, !322, !323, !324, !325, !340}
!316 = !DIDerivedType(tag: DW_TAG_member, name: "priority", scope: !314, file: !6, line: 66208, baseType: !116, size: 4, flags: DIFlagBitField, extraData: i64 0)
!317 = !DIDerivedType(tag: DW_TAG_member, name: "version", scope: !314, file: !6, line: 66209, baseType: !116, size: 4, offset: 4, flags: DIFlagBitField, extraData: i64 0)
!318 = !DIDerivedType(tag: DW_TAG_member, name: "flow_lbl", scope: !314, file: !6, line: 66210, baseType: !319, size: 24, offset: 8)
!319 = !DICompositeType(tag: DW_TAG_array_type, baseType: !116, size: 24, elements: !320)
!320 = !{!321}
!321 = !DISubrange(count: 3)
!322 = !DIDerivedType(tag: DW_TAG_member, name: "payload_len", scope: !314, file: !6, line: 66211, baseType: !110, size: 16, offset: 32)
!323 = !DIDerivedType(tag: DW_TAG_member, name: "nexthdr", scope: !314, file: !6, line: 66212, baseType: !116, size: 8, offset: 48)
!324 = !DIDerivedType(tag: DW_TAG_member, name: "hop_limit", scope: !314, file: !6, line: 66213, baseType: !116, size: 8, offset: 56)
!325 = !DIDerivedType(tag: DW_TAG_member, name: "saddr", scope: !314, file: !6, line: 66214, baseType: !326, size: 128, offset: 64)
!326 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "in6_addr", file: !6, line: 9641, size: 128, elements: !327)
!327 = !{!328}
!328 = !DIDerivedType(tag: DW_TAG_member, name: "in6_u", scope: !326, file: !6, line: 9646, baseType: !329, size: 128)
!329 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !326, file: !6, line: 9642, size: 128, elements: !330)
!330 = !{!331, !335, !339}
!331 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr8", scope: !329, file: !6, line: 9643, baseType: !332, size: 128)
!332 = !DICompositeType(tag: DW_TAG_array_type, baseType: !116, size: 128, elements: !333)
!333 = !{!334}
!334 = !DISubrange(count: 16)
!335 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr16", scope: !329, file: !6, line: 9644, baseType: !336, size: 128)
!336 = !DICompositeType(tag: DW_TAG_array_type, baseType: !110, size: 128, elements: !337)
!337 = !{!338}
!338 = !DISubrange(count: 8)
!339 = !DIDerivedType(tag: DW_TAG_member, name: "u6_addr32", scope: !329, file: !6, line: 9645, baseType: !70, size: 128)
!340 = !DIDerivedType(tag: DW_TAG_member, name: "daddr", scope: !314, file: !6, line: 66215, baseType: !326, size: 128, offset: 192)
!341 = !{i32 7, !"Dwarf Version", i32 5}
!342 = !{i32 2, !"Debug Info Version", i32 3}
!343 = !{i32 1, !"wchar_size", i32 4}
!344 = !{i32 7, !"frame-pointer", i32 2}
!345 = !{!"Ubuntu clang version 14.0.0-1ubuntu1"}
!346 = !DILocation(line: 0, scope: !80)
!347 = !DILocation(line: 147, column: 37, scope: !80)
!348 = !{!349, !350, i64 0}
!349 = !{!"xdp_md", !350, i64 0, !350, i64 4, !350, i64 8, !350, i64 12, !350, i64 16, !350, i64 20}
!350 = !{!"int", !351, i64 0}
!351 = !{!"omnipotent char", !352, i64 0}
!352 = !{!"Simple C/C++ TBAA"}
!353 = !DILocation(line: 147, column: 26, scope: !80)
!354 = !DILocation(line: 147, column: 18, scope: !80)
!355 = !DILocation(line: 148, column: 41, scope: !80)
!356 = !{!349, !350, i64 4}
!357 = !DILocation(line: 148, column: 30, scope: !80)
!358 = !DILocation(line: 148, column: 22, scope: !80)
!359 = !DILocation(line: 150, column: 5, scope: !360)
!360 = distinct !DILexicalBlock(scope: !80, file: !3, line: 150, column: 5)
!361 = !DILocation(line: 152, column: 5, scope: !80)
!362 = !DILocation(line: 152, column: 14, scope: !80)
!363 = !DILocation(line: 154, column: 18, scope: !80)
!364 = !DILocation(line: 154, column: 11, scope: !80)
!365 = !DILocation(line: 154, column: 16, scope: !80)
!366 = !{!367, !368, i64 0}
!367 = !{!"S", !368, i64 0}
!368 = !{!"long long", !351, i64 0}
!369 = !DILocation(line: 155, column: 11, scope: !80)
!370 = !DILocation(line: 156, column: 9, scope: !371)
!371 = distinct !DILexicalBlock(scope: !80, file: !3, line: 156, column: 9)
!372 = !DILocation(line: 156, column: 9, scope: !80)
!373 = !DILocation(line: 157, column: 9, scope: !374)
!374 = distinct !DILexicalBlock(scope: !371, file: !3, line: 157, column: 9)
!375 = !DILocation(line: 157, column: 9, scope: !371)
!376 = !DILocation(line: 160, column: 14, scope: !377)
!377 = distinct !DILexicalBlock(scope: !80, file: !3, line: 160, column: 9)
!378 = !DILocation(line: 160, column: 38, scope: !377)
!379 = !DILocation(line: 160, column: 9, scope: !80)
!380 = !DILocation(line: 163, column: 9, scope: !381)
!381 = distinct !DILexicalBlock(scope: !80, file: !3, line: 163, column: 9)
!382 = !{!383, !384, i64 12}
!383 = !{!"ethhdr", !351, i64 0, !351, i64 6, !384, i64 12}
!384 = !{!"short", !351, i64 0}
!385 = !DILocation(line: 163, column: 33, scope: !381)
!386 = !DILocation(line: 163, column: 9, scope: !80)
!387 = !DILocation(line: 167, column: 38, scope: !388)
!388 = distinct !DILexicalBlock(scope: !80, file: !3, line: 167, column: 9)
!389 = !DILocation(line: 167, column: 61, scope: !388)
!390 = !DILocation(line: 167, column: 9, scope: !80)
!391 = !DILocation(line: 170, column: 14, scope: !392)
!392 = distinct !DILexicalBlock(scope: !80, file: !3, line: 170, column: 9)
!393 = !{!394, !351, i64 9}
!394 = !{!"iphdr", !351, i64 0, !351, i64 0, !351, i64 1, !384, i64 2, !384, i64 4, !384, i64 6, !351, i64 8, !351, i64 9, !384, i64 10, !350, i64 12, !350, i64 16}
!395 = !DILocation(line: 170, column: 23, scope: !392)
!396 = !DILocation(line: 170, column: 9, scope: !80)
!397 = !DILocation(line: 171, column: 9, scope: !398)
!398 = distinct !DILexicalBlock(scope: !392, file: !3, line: 171, column: 9)
!399 = !{!394, !350, i64 12}
!400 = !DILocation(line: 171, column: 9, scope: !392)
!401 = !DILocation(line: 173, column: 5, scope: !402)
!402 = distinct !DILexicalBlock(scope: !80, file: !3, line: 173, column: 5)
!403 = !DILocation(line: 175, column: 14, scope: !130)
!404 = !DILocation(line: 175, column: 20, scope: !130)
!405 = !DILocation(line: 175, column: 9, scope: !80)
!406 = !DILocation(line: 0, scope: !129)
!407 = !DILocation(line: 178, column: 13, scope: !408)
!408 = distinct !DILexicalBlock(scope: !129, file: !3, line: 178, column: 13)
!409 = !DILocation(line: 178, column: 32, scope: !408)
!410 = !DILocation(line: 178, column: 13, scope: !129)
!411 = !DILocation(line: 181, column: 22, scope: !129)
!412 = !DILocation(line: 181, column: 20, scope: !129)
!413 = !{!394, !350, i64 16}
!414 = !DILocation(line: 182, column: 24, scope: !129)
!415 = !{!351, !351, i64 0}
!416 = !DILocation(line: 183, column: 5, scope: !129)
!417 = !DILocation(line: 186, column: 20, scope: !418)
!418 = distinct !DILexicalBlock(scope: !130, file: !3, line: 185, column: 5)
!419 = !DILocation(line: 187, column: 24, scope: !418)
!420 = !DILocation(line: 189, column: 16, scope: !80)
!421 = !DILocation(line: 190, column: 22, scope: !80)
!422 = !DILocalVariable(name: "iph", arg: 1, scope: !423, file: !3, line: 86, type: !112)
!423 = distinct !DISubprogram(name: "iph_csum", scope: !3, file: !3, line: 86, type: !424, scopeLine: 87, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !426)
!424 = !DISubroutineType(types: !425)
!425 = !{!61, !112}
!426 = !{!422, !427}
!427 = !DILocalVariable(name: "csum", scope: !423, file: !3, line: 89, type: !101)
!428 = !DILocation(line: 0, scope: !423, inlinedAt: !429)
!429 = distinct !DILocation(line: 192, column: 18, scope: !80)
!430 = !DILocation(line: 88, column: 16, scope: !423, inlinedAt: !429)
!431 = !{!394, !384, i64 10}
!432 = !DILocation(line: 89, column: 51, scope: !423, inlinedAt: !429)
!433 = !DILocation(line: 89, column: 31, scope: !423, inlinedAt: !429)
!434 = !DILocalVariable(name: "csum", arg: 1, scope: !435, file: !3, line: 72, type: !191)
!435 = distinct !DISubprogram(name: "csum_fold_helper", scope: !3, file: !3, line: 72, type: !436, scopeLine: 73, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !438)
!436 = !DISubroutineType(types: !437)
!437 = !{!61, !191}
!438 = !{!434, !439}
!439 = !DILocalVariable(name: "i", scope: !435, file: !3, line: 74, type: !83)
!440 = !DILocation(line: 0, scope: !435, inlinedAt: !441)
!441 = distinct !DILocation(line: 90, column: 12, scope: !423, inlinedAt: !429)
!442 = !DILocation(line: 78, column: 18, scope: !443, inlinedAt: !441)
!443 = distinct !DILexicalBlock(scope: !444, file: !3, line: 78, column: 13)
!444 = distinct !DILexicalBlock(scope: !445, file: !3, line: 77, column: 5)
!445 = distinct !DILexicalBlock(scope: !446, file: !3, line: 76, column: 5)
!446 = distinct !DILexicalBlock(scope: !435, file: !3, line: 76, column: 5)
!447 = !DILocation(line: 78, column: 13, scope: !444, inlinedAt: !441)
!448 = !DILocation(line: 81, column: 12, scope: !435, inlinedAt: !441)
!449 = !DILocation(line: 192, column: 16, scope: !80)
!450 = !DILocation(line: 194, column: 5, scope: !80)
!451 = !DILocation(line: 195, column: 1, scope: !80)
!452 = distinct !DISubprogram(name: "_selector", scope: !3, file: !3, line: 198, type: !453, scopeLine: 198, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !455)
!453 = !DISubroutineType(types: !454)
!454 = !{!44, !271}
!455 = !{!456, !457, !458, !459, !460, !461, !462, !463}
!456 = !DILocalVariable(name: "reuse", arg: 1, scope: !452, file: !3, line: 198, type: !271)
!457 = !DILocalVariable(name: "action", scope: !452, file: !3, line: 199, type: !44)
!458 = !DILocalVariable(name: "ip", scope: !452, file: !3, line: 200, type: !113)
!459 = !DILocalVariable(name: "ipv6", scope: !452, file: !3, line: 201, type: !314)
!460 = !DILocalVariable(name: "key", scope: !452, file: !3, line: 203, type: !63)
!461 = !DILocalVariable(name: "is_ipv4", scope: !452, file: !3, line: 205, type: !83)
!462 = !DILocalVariable(name: "targets", scope: !452, file: !3, line: 206, type: !59)
!463 = !DILocalVariable(name: "balancer_count", scope: !452, file: !3, line: 232, type: !464)
!464 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !77, size: 64)
!465 = !DILocation(line: 0, scope: !452)
!466 = !DILocation(line: 200, column: 3, scope: !452)
!467 = !DILocation(line: 200, column: 16, scope: !452)
!468 = !DILocation(line: 201, column: 3, scope: !452)
!469 = !DILocation(line: 201, column: 18, scope: !452)
!470 = !DILocation(line: 203, column: 3, scope: !452)
!471 = !DILocation(line: 205, column: 24, scope: !452)
!472 = !{!473, !350, i64 20}
!473 = !{!"sk_reuseport_md", !351, i64 0, !351, i64 8, !350, i64 16, !350, i64 20, !350, i64 24, !350, i64 28, !350, i64 32, !351, i64 40, !351, i64 48}
!474 = !DILocation(line: 205, column: 37, scope: !452)
!475 = !DILocation(line: 209, column: 3, scope: !452)
!476 = !DILocation(line: 210, column: 3, scope: !452)
!477 = !DILocation(line: 212, column: 18, scope: !452)
!478 = !{!473, !350, i64 24}
!479 = !DILocation(line: 212, column: 3, scope: !452)
!480 = !DILocation(line: 218, column: 7, scope: !481)
!481 = distinct !DILexicalBlock(scope: !452, file: !3, line: 212, column: 31)
!482 = !DILocation(line: 0, scope: !481)
!483 = !DILocation(line: 226, column: 6, scope: !452)
!484 = !DILocation(line: 227, column: 5, scope: !485)
!485 = distinct !DILexicalBlock(scope: !486, file: !3, line: 226, column: 14)
!486 = distinct !DILexicalBlock(scope: !452, file: !3, line: 226, column: 6)
!487 = !DILocation(line: 228, column: 3, scope: !485)
!488 = !DILocation(line: 229, column: 5, scope: !489)
!489 = distinct !DILexicalBlock(scope: !486, file: !3, line: 228, column: 10)
!490 = !DILocation(line: 232, column: 31, scope: !452)
!491 = !DILocation(line: 233, column: 8, scope: !492)
!492 = distinct !DILexicalBlock(scope: !452, file: !3, line: 233, column: 7)
!493 = !DILocation(line: 233, column: 23, scope: !492)
!494 = !DILocation(line: 233, column: 26, scope: !492)
!495 = !{!350, !350, i64 0}
!496 = !DILocation(line: 233, column: 42, scope: !492)
!497 = !DILocation(line: 233, column: 7, scope: !452)
!498 = !DILocation(line: 235, column: 5, scope: !499)
!499 = distinct !DILexicalBlock(scope: !492, file: !3, line: 233, column: 48)
!500 = !DILocation(line: 236, column: 3, scope: !499)
!501 = !DILocation(line: 243, column: 6, scope: !452)
!502 = !DILocation(line: 244, column: 37, scope: !503)
!503 = distinct !DILexicalBlock(scope: !504, file: !3, line: 243, column: 14)
!504 = distinct !DILexicalBlock(scope: !452, file: !3, line: 243, column: 6)
!505 = !DILocation(line: 244, column: 16, scope: !503)
!506 = !DILocalVariable(name: "ip_p1", arg: 1, scope: !507, file: !3, line: 115, type: !63)
!507 = distinct !DISubprogram(name: "hash", scope: !3, file: !3, line: 115, type: !508, scopeLine: 115, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !510)
!508 = !DISubroutineType(types: !509)
!509 = !{!63, !63, !63, !63, !63}
!510 = !{!506, !511, !512, !513, !514, !515, !516, !517, !518}
!511 = !DILocalVariable(name: "ip_p2", arg: 2, scope: !507, file: !3, line: 115, type: !63)
!512 = !DILocalVariable(name: "ip_p3", arg: 3, scope: !507, file: !3, line: 115, type: !63)
!513 = !DILocalVariable(name: "ip_p4", arg: 4, scope: !507, file: !3, line: 115, type: !63)
!514 = !DILocalVariable(name: "a", scope: !507, file: !3, line: 116, type: !63)
!515 = !DILocalVariable(name: "b", scope: !507, file: !3, line: 116, type: !63)
!516 = !DILocalVariable(name: "c", scope: !507, file: !3, line: 116, type: !63)
!517 = !DILocalVariable(name: "initval", scope: !507, file: !3, line: 116, type: !63)
!518 = !DILocalVariable(name: "n", scope: !507, file: !3, line: 116, type: !161)
!519 = !DILocation(line: 0, scope: !507, inlinedAt: !520)
!520 = distinct !DILocation(line: 244, column: 11, scope: !503)
!521 = !DILocation(line: 119, column: 7, scope: !507, inlinedAt: !520)
!522 = !DILocation(line: 120, column: 9, scope: !523, inlinedAt: !520)
!523 = distinct !DILexicalBlock(scope: !507, file: !3, line: 120, column: 7)
!524 = !DILocation(line: 120, column: 7, scope: !507, inlinedAt: !520)
!525 = !DILocation(line: 125, column: 7, scope: !526, inlinedAt: !520)
!526 = distinct !DILexicalBlock(scope: !507, file: !3, line: 125, column: 7)
!527 = !DILocation(line: 125, column: 10, scope: !526, inlinedAt: !520)
!528 = !DILocation(line: 125, column: 7, scope: !507, inlinedAt: !520)
!529 = !DILocation(line: 127, column: 10, scope: !530, inlinedAt: !520)
!530 = distinct !DILexicalBlock(scope: !526, file: !3, line: 125, column: 16)
!531 = !DILocation(line: 127, column: 8, scope: !530, inlinedAt: !520)
!532 = !DILocation(line: 132, column: 3, scope: !530, inlinedAt: !520)
!533 = !DILocation(line: 134, column: 13, scope: !507, inlinedAt: !520)
!534 = !DILocation(line: 136, column: 11, scope: !507, inlinedAt: !520)
!535 = !DILocation(line: 137, column: 37, scope: !507, inlinedAt: !520)
!536 = !DILocalVariable(name: "word", arg: 1, scope: !537, file: !3, line: 113, type: !64)
!537 = distinct !DISubprogram(name: "rol32", scope: !3, file: !3, line: 113, type: !538, scopeLine: 113, flags: DIFlagPrototyped | DIFlagAllCallsDescribed, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !2, retainedNodes: !540)
!538 = !DISubroutineType(types: !539)
!539 = !{!64, !64, !7}
!540 = !{!536, !541}
!541 = !DILocalVariable(name: "shift", arg: 2, scope: !537, file: !3, line: 113, type: !7)
!542 = !DILocation(line: 0, scope: !537, inlinedAt: !543)
!543 = distinct !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !520)
!544 = distinct !DILexicalBlock(scope: !507, file: !3, line: 141, column: 3)
!545 = !DILocation(line: 113, column: 91, scope: !537, inlinedAt: !543)
!546 = !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !520)
!547 = !DILocation(line: 0, scope: !537, inlinedAt: !548)
!548 = distinct !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !520)
!549 = !DILocation(line: 113, column: 91, scope: !537, inlinedAt: !548)
!550 = !DILocation(line: 0, scope: !537, inlinedAt: !551)
!551 = distinct !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !520)
!552 = !DILocation(line: 113, column: 91, scope: !537, inlinedAt: !551)
!553 = !DILocation(line: 0, scope: !537, inlinedAt: !554)
!554 = distinct !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !520)
!555 = !DILocation(line: 113, column: 91, scope: !537, inlinedAt: !554)
!556 = !DILocation(line: 0, scope: !537, inlinedAt: !557)
!557 = distinct !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !520)
!558 = !DILocation(line: 113, column: 91, scope: !537, inlinedAt: !557)
!559 = !DILocation(line: 0, scope: !537, inlinedAt: !560)
!560 = distinct !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !520)
!561 = !DILocation(line: 113, column: 91, scope: !537, inlinedAt: !560)
!562 = !DILocation(line: 0, scope: !537, inlinedAt: !563)
!563 = distinct !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !520)
!564 = !DILocation(line: 113, column: 91, scope: !537, inlinedAt: !563)
!565 = !DILocation(line: 142, column: 3, scope: !507, inlinedAt: !520)
!566 = !DILocation(line: 247, column: 25, scope: !567)
!567 = distinct !DILexicalBlock(scope: !504, file: !3, line: 245, column: 10)
!568 = !DILocation(line: 247, column: 7, scope: !567)
!569 = !DILocation(line: 248, column: 25, scope: !567)
!570 = !DILocation(line: 248, column: 7, scope: !567)
!571 = !DILocation(line: 249, column: 25, scope: !567)
!572 = !DILocation(line: 249, column: 7, scope: !567)
!573 = !DILocation(line: 250, column: 25, scope: !567)
!574 = !DILocation(line: 250, column: 7, scope: !567)
!575 = !DILocation(line: 0, scope: !507, inlinedAt: !576)
!576 = distinct !DILocation(line: 246, column: 11, scope: !567)
!577 = !DILocation(line: 119, column: 7, scope: !507, inlinedAt: !576)
!578 = !DILocation(line: 120, column: 9, scope: !523, inlinedAt: !576)
!579 = !DILocation(line: 120, column: 7, scope: !507, inlinedAt: !576)
!580 = !DILocation(line: 125, column: 7, scope: !526, inlinedAt: !576)
!581 = !DILocation(line: 125, column: 10, scope: !526, inlinedAt: !576)
!582 = !DILocation(line: 125, column: 7, scope: !507, inlinedAt: !576)
!583 = !DILocation(line: 127, column: 10, scope: !530, inlinedAt: !576)
!584 = !DILocation(line: 127, column: 8, scope: !530, inlinedAt: !576)
!585 = !DILocation(line: 132, column: 3, scope: !530, inlinedAt: !576)
!586 = !DILocation(line: 134, column: 13, scope: !507, inlinedAt: !576)
!587 = !DILocation(line: 136, column: 11, scope: !507, inlinedAt: !576)
!588 = !DILocation(line: 137, column: 13, scope: !507, inlinedAt: !576)
!589 = !DILocation(line: 137, column: 21, scope: !507, inlinedAt: !576)
!590 = !DILocation(line: 137, column: 29, scope: !507, inlinedAt: !576)
!591 = !DILocation(line: 137, column: 37, scope: !507, inlinedAt: !576)
!592 = !DILocation(line: 0, scope: !537, inlinedAt: !593)
!593 = distinct !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !576)
!594 = !DILocation(line: 113, column: 91, scope: !537, inlinedAt: !593)
!595 = !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !576)
!596 = !DILocation(line: 0, scope: !537, inlinedAt: !597)
!597 = distinct !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !576)
!598 = !DILocation(line: 113, column: 91, scope: !537, inlinedAt: !597)
!599 = !DILocation(line: 0, scope: !537, inlinedAt: !600)
!600 = distinct !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !576)
!601 = !DILocation(line: 113, column: 91, scope: !537, inlinedAt: !600)
!602 = !DILocation(line: 0, scope: !537, inlinedAt: !603)
!603 = distinct !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !576)
!604 = !DILocation(line: 113, column: 91, scope: !537, inlinedAt: !603)
!605 = !DILocation(line: 0, scope: !537, inlinedAt: !606)
!606 = distinct !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !576)
!607 = !DILocation(line: 113, column: 91, scope: !537, inlinedAt: !606)
!608 = !DILocation(line: 0, scope: !537, inlinedAt: !609)
!609 = distinct !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !576)
!610 = !DILocation(line: 113, column: 91, scope: !537, inlinedAt: !609)
!611 = !DILocation(line: 0, scope: !537, inlinedAt: !612)
!612 = distinct !DILocation(line: 141, column: 3, scope: !544, inlinedAt: !576)
!613 = !DILocation(line: 113, column: 91, scope: !537, inlinedAt: !612)
!614 = !DILocation(line: 142, column: 3, scope: !507, inlinedAt: !576)
!615 = !DILocation(line: 0, scope: !504)
!616 = !DILocation(line: 263, column: 7, scope: !617)
!617 = distinct !DILexicalBlock(scope: !452, file: !3, line: 263, column: 7)
!618 = !DILocation(line: 263, column: 56, scope: !617)
!619 = !DILocation(line: 276, column: 1, scope: !452)
