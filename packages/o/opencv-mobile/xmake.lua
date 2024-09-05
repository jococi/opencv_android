---
--- Created by funui.
--- DateTime: 2024/9/5 上午11:40
---
package("opencv-mobile")
    set_homepage("https://github.com/nihui/opencv-mobile")
    set_description("该项目为不同平台提供了 opencv 库的最小构建。")

    set_urls("https://github.com/nihui/opencv-mobile/releases/download/v29/opencv-mobile-$(version).zip")
    add_versions("4.10.0", "e9209285ad4d682536db4505bc06e46b94b9e56d91896e16c2853c83a870f004")

    add_deps("cmake")

    on_install( function (package)
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
         if is_plat("windows") then
             table.insert(configs, "-DBUILD_opencv_world=OFF")
             table.insert(configs, "-DCMAKE_INSTALL_PREFIX=install")
         end

      import("package.tools.cmake").install(package, configs)
    end)

   on_test(function (package)
        assert(package:check_cxxsnippets({test = [[
           #include <opencv2/opencv.hpp>
            #include <iostream>

            int main(int argc, char** argv) {
                std::cout << "opencv version is: "<<cv::getVersionString()<< std::endl;
                return 0;
            }
        ]]}, {configs = {languages = "c++17"}}))
    end)