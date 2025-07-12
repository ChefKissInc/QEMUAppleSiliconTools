#!/usr/bin/env fish

if test ! -e "dyld_shared_cache_arm64e.orig"
    echo "Original shared cache is not in place."
    exit
end

echo "Restoring original DYLD..."
dd if=dyld_shared_cache_arm64e.orig of=/Volumes/System/System/Library/Caches/com.apple.dyld/dyld_shared_cache_arm64e

echo "Applying CoreImage patches..."
# Force `wrapGLIsUsable` to return false.
printf '\x00\x00\x80\xD2' | dd bs=1 count=4 seek=32044804 conv=notrunc of=/Volumes/System/System/Library/Caches/com.apple.dyld/dyld_shared_cache_arm64e
printf '\xC0\x03\x5F\xD6' | dd bs=1 count=4 seek=32044808 conv=notrunc of=/Volumes/System/System/Library/Caches/com.apple.dyld/dyld_shared_cache_arm64e

echo "Applying QuartzCore patches..."
# Fix `CA::OGL::AsynchronousDispatcher::renderer` to use software context.
printf '\x1F\x20\x03\xD5' | dd bs=1 count=4 seek=135542256 conv=notrunc of=/Volumes/System/System/Library/Caches/com.apple.dyld/dyld_shared_cache_arm64e
printf '\x1F\x20\x03\xD5' | dd bs=1 count=4 seek=135542260 conv=notrunc of=/Volumes/System/System/Library/Caches/com.apple.dyld/dyld_shared_cache_arm64e
printf '\x1F\x20\x03\xD5' | dd bs=1 count=4 seek=135542264 conv=notrunc of=/Volumes/System/System/Library/Caches/com.apple.dyld/dyld_shared_cache_arm64e
printf '\xDD\x18\x02\x94' | dd bs=1 count=4 seek=135542284 conv=notrunc of=/Volumes/System/System/Library/Caches/com.apple.dyld/dyld_shared_cache_arm64e
printf '\x1F\x20\x03\xD5' | dd bs=1 count=4 seek=135542368 conv=notrunc of=/Volumes/System/System/Library/Caches/com.apple.dyld/dyld_shared_cache_arm64e
printf '\x1F\x20\x03\xD5' | dd bs=1 count=4 seek=135542372 conv=notrunc of=/Volumes/System/System/Library/Caches/com.apple.dyld/dyld_shared_cache_arm64e

echo "Applying SpringBoardFoundation.framework patches..."
# Force `shouldUseXPCForRendering` to return true.
printf '\x20\x00\x80\xD2' | dd bs=1 count=4 seek=367611672 conv=notrunc of=/Volumes/System/System/Library/Caches/com.apple.dyld/dyld_shared_cache_arm64e
printf '\xC0\x03\x5F\xD6' | dd bs=1 count=4 seek=367611676 conv=notrunc of=/Volumes/System/System/Library/Caches/com.apple.dyld/dyld_shared_cache_arm64e
