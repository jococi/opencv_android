---
--- Created by funui.
--- DateTime: 2024/9/5 上午11:40
---
package("opencv-mobile")
set_homepage("https://github.com/nihui/opencv-mobile")
set_description("该项目为不同平台提供了 opencv 库的最小构建。")

set_urls("https://github.com/nihui/opencv-mobile/releases/download/v29/opencv-mobile-$(version).zip")
add_versions("4.10.0", "e9209285ad4d682536db4505bc06e46b94b9e56d91896e16c2853c83a870f004")

add_configs("shared", { description = "Build shared library.", default = false, type = "boolean", readonly = true })


add_deps("cmake")



on_install(function(package)
    local configs = {
        "-DBUILD_ZLIB=OFF",
        "-DBUILD_TIFF=OFF",
        "-DBUILD_OPENJPEG=OFF",
        "-DBUILD_JASPER=OFF",
        "-DBUILD_JPEG=OFF",
        "-DBUILD_PNG=OFF",
        "-DBUILD_OPENEXR=OFF",
        "-DBUILD_WEBP=OFF",
        "-DBUILD_TBB=OFF",
        "-DBUILD_IPP_IW=OFF",
        "-DBUILD_ITT=OFF",
        "-DWITH_AVFOUNDATION=OFF",
        "-DWITH_CAP_IOS=OFF",
        "-DWITH_CAROTENE=OFF",
        "-DWITH_CPUFEATURES=OFF",
        "-DWITH_EIGEN=OFF",
        "-DWITH_FFMPEG=OFF",
        "-DWITH_GSTREAMER=OFF",
        "-DWITH_GTK=OFF",
        "-DWITH_IPP=OFF",
        "-DWITH_HALIDE=OFF",
        "-DWITH_VULKAN=OFF",
        "-DWITH_INF_ENGINE=OFF",
        "-DWITH_NGRAPH=OFF",
        "-DWITH_JASPER=OFF",
        "-DWITH_OPENJPEG=OFF",
        "-DWITH_JPEG=OFF",
        "-DWITH_WEBP=OFF",
        "-DWITH_OPENEXR=OFF",
        "-DWITH_PNG=OFF",
        "-DWITH_TIFF=OFF",
        "-DWITH_OPENVX=OFF",
        "-DWITH_GDCM=OFF",
        "-DWITH_TBB=OFF",
        "-DWITH_HPX=OFF",
        "-DWITH_OPENMP=ON",
        "-DWITH_PTHREADS_PF=OFF",
        "-DWITH_V4L=OFF",
        "-DWITH_CLP=OFF",
        "-DWITH_OPENCL=OFF",
        "-DWITH_OPENCL_SVM=OFF",
        "-DWITH_VA=OFF",
        "-DWITH_VA_INTEL=OFF",
        "-DWITH_ITT=OFF",
        "-DWITH_PROTOBUF=OFF",
        "-DWITH_IMGCODEC_HDR=OFF",
        "-DWITH_IMGCODEC_SUNRASTER=OFF",
        "-DWITH_IMGCODEC_PXM=OFF",
        "-DWITH_IMGCODEC_PFM=OFF",
        "-DWITH_QUIRC=OFF",
        "-DWITH_ANDROID_MEDIANDK=OFF",
        "-DWITH_TENGINE=OFF",
        "-DWITH_ONNX=OFF",
        "-DWITH_TIMVX=OFF",
        "-DWITH_OBSENSOR=OFF",
        "-DWITH_CANN=OFF",
        "-DWITH_FLATBUFFERS=OFF",
        "-DBUILD_SHARED_LIBS=OFF",
        "-DBUILD_opencv_apps=OFF",
        "-DBUILD_ANDROID_PROJECTS=OFF",
        "-DBUILD_ANDROID_EXAMPLES=OFF",
        "-DBUILD_DOCS=OFF",
        "-DBUILD_EXAMPLES=OFF",
        "-DBUILD_PACKAGE=OFF",
        "-DBUILD_PERF_TESTS=OFF",
        "-DBUILD_TESTS=OFF",
        "-DBUILD_WITH_STATIC_CRT=OFF",
        "-DBUILD_FAT_JAVA_LIB=OFF",
        "-DBUILD_ANDROID_SERVICE=OFF",
        "-DBUILD_JAVA=OFF",
        "-DBUILD_OBJC=OFF",
        "-DBUILD_KOTLIN_EXTENSIONS=OFF",
        "-DENABLE_PRECOMPILED_HEADERS=OFF",
        "-DENABLE_FAST_MATH=ON",
        "-DCV_TRACE=OFF",
        "-DBUILD_opencv_java=OFF",
        "-DBUILD_opencv_gapi=OFF",
        "-DBUILD_opencv_objc=OFF",
        "-DBUILD_opencv_js=OFF",
        "-DBUILD_opencv_ts=OFF",
        "-DBUILD_opencv_python2=OFF",
        "-DBUILD_opencv_python3=OFF",
        "-DBUILD_opencv_dnn=OFF",
        "-DBUILD_opencv_imgcodecs=OFF",
        "-DBUILD_opencv_videoio=OFF",
        "-DBUILD_opencv_calib3d=OFF",
        "-DBUILD_opencv_flann=OFF",
        "-DBUILD_opencv_objdetect=OFF",
        "-DBUILD_opencv_stitching=OFF",
        "-DBUILD_opencv_ml=OFF",
    }
    table.insert(configs, "-DCMAKE_BUILD_TYPE=" .. (package:is_debug() and "Debug" or "Release"))
    if package:config("shared") then
        table.insert(configs, "-DBUILD_SHARED_LIBS=ON")
    end
    if package:is_plat("windows") then
        table.insert(configs, "-DBUILD_opencv_world=OFF")
    elseif package:is_plat("android") then
        table.insert(configs, "-DBUILD_opencv_world=OFF")
        table.insert(configs, "-DOPENCV_DISABLE_FILESYSTEM_SUPPORT=ON")
        table.insert(configs, "-DCMAKE_POLICY_DEFAULT_CMP0057=NEW")
        if package:is_arch("arm64-v8a") then
            table.insert(configs, "-DOPENCV_EXTRA_FLAGS=\"-mno-outline-atomics\"")
        end
    end

    import("package.tools.cmake").install(package, configs)
    --for _, link in ipairs({"opencv_core","opencv_features2d","opencv_highgui","opencv_imgproc","opencv_photo","opencv_video"}) do
    --    local reallink = link
    --    if package:is_plat("windows", "mingw") then
    --        reallink = reallink .. package:version():gsub("%.", "")
    --        reallink = reallink .. (package:debug() and "d" or "")
    --    end
    --    package:add("links", reallink)
    --end

    if package:is_plat("windows") then
        local arch = "x64"
        if package:is_arch("x86") then
            arch = "x86"
        elseif package:is_arch("arm64") then
            arch = "ARM64"
        end
        local linkdir = (package:config("shared") and "lib" or "staticlib")
        local vs = package:toolchain("msvc"):config("vs")
        local vc_ver = "vc13"
        if vs == "2015" then
            vc_ver = "vc14"
        elseif vs == "2017" then
            vc_ver = "vc15"
        elseif vs == "2019" then
            vc_ver = "vc16"
        elseif vs == "2022" then
            vc_ver = "vc17"
        end

        local installdir = package:installdir(arch, vc_ver)
        local libfiles = {}
        table.join2(libfiles, os.files(path.join(package:installdir(), linkdir, "*.lib")))
        table.join2(libfiles, os.files(path.join(package:installdir(), arch, vc_ver, linkdir, "*.lib")))
        for _, f in ipairs(libfiles) do
            if not f:match("opencv_.+") then
                package:add("links", path.basename(f))
            end
        end
        package:addenv("PATH", path.join(arch, vc_ver, "bin"))
    elseif package:is_plat("android") then
        local includedir = package:installdir("sdk", "native", "jni", "include")
        os.cp(includedir, package:installdir())

        local libdir = package:installdir("sdk", "native", (package:config("shared") and "lib" or "staticlibs"),
                package:arch())
        os.trycp(libdir .. "/**.a", package:installdir("lib"))
        os.trycp(libdir .. "/**.so", package:installdir("lib"))
    end
end)
