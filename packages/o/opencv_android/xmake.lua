package("opencv_android")
   if is_plat("android") then
        set_urls("https://github.com/opencv/opencv/releases/download/$(version)/opencv-$(version)-android-sdk.zip")
        add_versions("4.9.0", "d181481fdabf6c02b1b45a3b382a583c531bb4d6b0582d0fbbb686487f071218")
    end

    on_install("android", function (package)
        os.cp("sdk/native/jni/include", package:installdir())
        os.cp("sdk/native/staticlibs/$(arch)/*.a", package:installdir("lib"))
        os.cp("sdk/native/3rdparty/libs/$(arch)/*.a", package:installdir("lib"))
    -- os.cp("lib/$(arch)/*.dll", package:installdir("lib"))
    end)
