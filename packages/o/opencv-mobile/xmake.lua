---
--- Created by funui.
--- DateTime: 2024/9/5 上午11:40
---
package("opencv-mobile")
    set_homepage("https://github.com/nihui/opencv-mobile")
    set_description("该项目为不同平台提供了 opencv 库的最小构建。")
   if is_plat("android") then
        set_urls("https://github.com/nihui/opencv-mobile/releases/download/v29/opencv-mobile-$(version)-$(plat).zip")
        add_versions("4.10.0", "ddc9d8479f29a978a732826257671a5c28abeb4639b66b899c13dee39710a643")
        on_install("android", function (package)
                os.cp("sdk/native/jni/include", package:installdir())
                os.cp("sdk/native/staticlibs/$(arch)/*.a", package:installdir("lib"))
                end)
   elseif is_plat("iphoneos") then
        set_urls("https://github.com/nihui/opencv-mobile/releases/download/v29/opencv-mobile-$(version)-iOS.zip")
        add_versions("4.10.0", "ef30a9276ce899bc6016a2ed20b9258aedcd8af8915d1ecc7ac9ba7c64f4094a")
         on_install( function (package)
                os.cp("sdk/include", package:installdir())
                os.cp("sdk/lib/*.a", package:installdir("lib"))
                end)
    elseif is_plat("linux") then
        set_urls("https://github.com/nihui/opencv-mobile/releases/download/v29/opencv-mobile-$(version)-ubuntu-2004.zip")
        add_versions("4.10.0", "fe20ddfffb5710c85d6f4d486ba373dca7f66b2bf7336e11ecc309a608e03259")
         on_install( function (package)
                os.cp("include/opencv4", package:installdir())
                os.cp("lib/*.a", package:installdir("lib"))
                end)
    elseif is_plat("windows") then
            set_urls("https://github.com/nihui/opencv-mobile/releases/download/v29/opencv-mobile-$(version)-windows-vs2022.zip")
            add_versions("4.10.0", "2c779336dc5ff301f5c402a9190257e2ddfae46666c1f2ef51cf7f9f63ffad9d")
             on_install( function (package)
                    os.cp("$(arch)/include/", package:installdir())
                    os.cp("$(arch)/$(arch)/vc17/staticlib/*.lib", package:installdir("lib"))
                    end)
   end