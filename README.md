# photohack

Experimenting with PhotoKit to load non-system photo libraries to decode adjustment data and other useful info.

```sh
photohack path/to/some.photoslibrary UUID...
```

## Useful Framework Headers

### PhotoKit

* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/Frameworks/Photos/21/PHPhotoLibrary.h>
* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/Frameworks/Photos/21/PHAsset.h>

### NeutrinoCore

* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/PrivateFrameworks/NeutrinoCore/21/NUAdjustment.h>
* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/PrivateFrameworks/NeutrinoCore/21/NUGenericAdjustment.h>
* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/PrivateFrameworks/NeutrinoCore/21/NUAdjustmentSchema.h>
* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/PrivateFrameworks/NeutrinoCore/21/NUAdjustmentSerialization.h>

* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/PrivateFrameworks/NeutrinoCore/21/NUComposition.h>
* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/PrivateFrameworks/NeutrinoCore/21/NUGenericComposition.h>
* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/PrivateFrameworks/NeutrinoCore/21/NUCompositionSchema.h>

* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/PrivateFrameworks/NeutrinoCore/21/NUSetting.h>
* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/PrivateFrameworks/NeutrinoCore/21/NUBoolSetting.h>
* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/PrivateFrameworks/NeutrinoCore/21/NUEnumSetting.h>
* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/PrivateFrameworks/NeutrinoCore/21/NUNumberSetting.h>
* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/PrivateFrameworks/NeutrinoCore/21/NUOpaqueSetting.h>
* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/PrivateFrameworks/NeutrinoCore/21/NUArraySetting.h>
* <https://github.com/w0lfschild/macOS_headers/blob/master/macOS/PrivateFrameworks/NeutrinoCore/21/NUCompoundSetting.h>

TODO: May be able to use `NUAdjustmentSerialization` directly to load and adjustment plist file from disk and bypass
the permissions and other hacks for PhotoKit.


## Adjustments Schema

See the debugging section below for a more detail or [`schema-adjustments.json`](schema-adjustments.json) for
a JSON mapping of the following.

```
effect3D = {
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    intensity = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 1;\n    required = 0;\n}>";
    kind = "<NUEnumSetting values:(\n    3DVivid,\n    3DVividWarm,\n    3DVividCool,\n    3DDramatic,\n    3DDramaticWarm,\n    3DDramaticCool,\n    3DSilverplate,\n    3DNoir\n) attributes:{\n    default = 3DVivid;\n}>";
    version = "<NUNumberSetting min:0 max:1 attributes:{\n    required = 0;\n}>";
}
livePhotoKeyFrame = {
    scale = "<NUNumberSetting min:1 max:2147483647 attributes:{\n    default = 1;\n}>";
    time = "<NUNumberSetting min:0 max:9223372036854775807 attributes:{\n}>";
}
mute = {
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
}
whiteBalance = {
    auto = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
    colorType = "<NUEnumSetting values:(\n    neutralGray,\n    faceBalance,\n    tempTint,\n    warmTint\n) attributes:{\n    default = faceBalance;\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    faceI = "<NUNumberSetting min:-3 max:3 attributes:{\n    required = 0;\n}>";
    faceQ = "<NUNumberSetting min:-2 max:2 attributes:{\n    required = 0;\n}>";
    faceStrength = "<NUNumberSetting min:-3 max:3 attributes:{\n    required = 0;\n}>";
    faceWarmth = "<NUNumberSetting min:-3 max:3 attributes:{\n    required = 0;\n}>";
    grayI = "<NUNumberSetting min:-3 max:3 attributes:{\n    required = 0;\n}>";
    grayQ = "<NUNumberSetting min:-3 max:3 attributes:{\n    required = 0;\n}>";
    grayStrength = "<NUNumberSetting min:-3 max:3 attributes:{\n    default = 1;\n    required = 0;\n}>";
    grayWarmth = "<NUNumberSetting min:-3 max:3 attributes:{\n    required = 0;\n}>";
    grayY = "<NUNumberSetting min:-3 max:3 attributes:{\n    required = 0;\n}>";
    temperature = "<NUNumberSetting min:1000 max:32000 attributes:{\n    default = 5000;\n    identity = 5000;\n    required = 0;\n}>";
    tint = "<NUNumberSetting min:-150 max:150 attributes:{\n    default = 0;\n    required = 0;\n}>";
    warmFace = "<NUBoolSetting attributes:{\n    default = 0;\n    required = 0;\n}>";
    warmTemp = "<NUNumberSetting min:-2 max:2 attributes:{\n    default = 0;\n    required = 0;\n}>";
    warmTint = "<NUNumberSetting min:-2 max:2 attributes:{\n    default = 0;\n    required = 0;\n}>";
}
vignette = {
    auto = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    falloff = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 0;\n}>";
    intensity = "<NUNumberSetting min:-1 max:1 attributes:{\n    default = 0;\n}>";
    radius = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 0;\n}>";
}
definition = {
    auto = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    intensity = "<NUNumberSetting min:0 max:2 attributes:{\n    default = 0;\n}>";
}
levels = {
    auto = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
    blackDstBlue = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 0;\n    required = 0;\n}>";
    blackDstGreen = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 0;\n    required = 0;\n}>";
    blackDstRGB = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 0;\n    required = 0;\n}>";
    blackDstRed = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 0;\n    required = 0;\n}>";
    blackSrcBlue = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 0;\n    required = 0;\n}>";
    blackSrcGreen = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 0;\n    required = 0;\n}>";
    blackSrcRGB = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 0;\n    required = 0;\n}>";
    blackSrcRed = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 0;\n    required = 0;\n}>";
    colorSpace = "<NUEnumSetting values:(\n    \"Adobe RGB\",\n    sRGB,\n    \"Display P3\"\n) attributes:{\n    default = \"Display P3\";\n    required = 0;\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    hilightDstBlue = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.75\";\n    required = 0;\n}>";
    hilightDstGreen = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.75\";\n    required = 0;\n}>";
    hilightDstRGB = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.75\";\n    required = 0;\n}>";
    hilightDstRed = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.75\";\n    required = 0;\n}>";
    hilightSrcBlue = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.75\";\n    required = 0;\n}>";
    hilightSrcGreen = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.75\";\n    required = 0;\n}>";
    hilightSrcRGB = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.75\";\n    required = 0;\n}>";
    hilightSrcRed = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.75\";\n    required = 0;\n}>";
    midDstBlue = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.5\";\n    required = 0;\n}>";
    midDstGreen = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.5\";\n    required = 0;\n}>";
    midDstRGB = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.5\";\n    required = 0;\n}>";
    midDstRed = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.5\";\n    required = 0;\n}>";
    midSrcBlue = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.5\";\n    required = 0;\n}>";
    midSrcGreen = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.5\";\n    required = 0;\n}>";
    midSrcRGB = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.5\";\n    required = 0;\n}>";
    midSrcRed = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.5\";\n    required = 0;\n}>";
    shadowDstBlue = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.25\";\n    required = 0;\n}>";
    shadowDstGreen = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.25\";\n    required = 0;\n}>";
    shadowDstRGB = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.25\";\n    required = 0;\n}>";
    shadowDstRed = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.25\";\n    required = 0;\n}>";
    shadowSrcBlue = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.25\";\n    required = 0;\n}>";
    shadowSrcGreen = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.25\";\n    required = 0;\n}>";
    shadowSrcRGB = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.25\";\n    required = 0;\n}>";
    shadowSrcRed = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.25\";\n    required = 0;\n}>";
    whiteDstBlue = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 1;\n    required = 0;\n}>";
    whiteDstGreen = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 1;\n    required = 0;\n}>";
    whiteDstRGB = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 1;\n    required = 0;\n}>";
    whiteDstRed = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 1;\n    required = 0;\n}>";
    whiteSrcBlue = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 1;\n    required = 0;\n}>";
    whiteSrcGreen = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 1;\n    required = 0;\n}>";
    whiteSrcRGB = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 1;\n    required = 0;\n}>";
    whiteSrcRed = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 1;\n    required = 0;\n}>";
}
videoPosterFrame = {
    scale = "<NUNumberSetting min:1 max:2147483647 attributes:{\n    default = 1;\n}>";
    time = "<NUNumberSetting min:0 max:9223372036854775807 attributes:{\n}>";
}
redEye = {
    auto = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    iPhone = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
    inputCorrectionInfo = "<NUOpaqueSetting attributes:{\n    required = 0;\n}>";
}
smartBlackAndWhite = {
    auto = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    grain = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 0;\n}>";
    hue = "<NUNumberSetting min:-1 max:1 attributes:{\n    default = 0;\n}>";
    neutral = "<NUNumberSetting min:-1 max:1 attributes:{\n    default = 0;\n}>";
    strength = "<NUNumberSetting min:0 max:1 attributes:{\n    default = \"0.5\";\n}>";
    tone = "<NUNumberSetting min:-1 max:1 attributes:{\n    default = 0;\n}>";
}
orientation = {
    value = "<NUNumberSetting min:1 max:8 attributes:{\n    default = 1;\n}>";
}
curves = {
    auto = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    pointsB = "<NUArraySetting content:<NUCompoundSetting properties:{\n    editable = \"<NUBoolSetting attributes:{\\n}>\";\n    x = \"<NUNumberSetting min:0 max:2 attributes:{\\n}>\";\n    y = \"<NUNumberSetting min:0 max:2 attributes:{\\n}>\";\n} attributes:{\n}> attributes:{\n}>";
    pointsG = "<NUArraySetting content:<NUCompoundSetting properties:{\n    editable = \"<NUBoolSetting attributes:{\\n}>\";\n    x = \"<NUNumberSetting min:0 max:2 attributes:{\\n}>\";\n    y = \"<NUNumberSetting min:0 max:2 attributes:{\\n}>\";\n} attributes:{\n}> attributes:{\n}>";
    pointsL = "<NUArraySetting content:<NUCompoundSetting properties:{\n    editable = \"<NUBoolSetting attributes:{\\n}>\";\n    x = \"<NUNumberSetting min:0 max:2 attributes:{\\n}>\";\n    y = \"<NUNumberSetting min:0 max:2 attributes:{\\n}>\";\n} attributes:{\n}> attributes:{\n}>";
    pointsR = "<NUArraySetting content:<NUCompoundSetting properties:{\n    editable = \"<NUBoolSetting attributes:{\\n}>\";\n    x = \"<NUNumberSetting min:0 max:2 attributes:{\\n}>\";\n    y = \"<NUNumberSetting min:0 max:2 attributes:{\\n}>\";\n} attributes:{\n}> attributes:{\n}>";
}
noiseReduction = {
    auto = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
    edgeDetail = "<NUNumberSetting min:0 max:6 attributes:{\n    default = \"1.5\";\n    required = 0;\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    radius = "<NUNumberSetting min:0 max:10 attributes:{\n    default = 1;\n}>";
}
selectiveColor = {
    corrections = "<NUArraySetting content:<NUCompoundSetting properties:{\n    blue = \"<NUNumberSetting min:0 max:1 attributes:{\\n    required = 1;\\n}>\";\n    green = \"<NUNumberSetting min:0 max:1 attributes:{\\n    required = 1;\\n}>\";\n    hueShift = \"<NUNumberSetting min:-60 max:60 attributes:{\\n    default = 0;\\n    required = 1;\\n}>\";\n    luminance = \"<NUNumberSetting min:-70 max:70 attributes:{\\n    default = 0;\\n    required = 1;\\n}>\";\n    red = \"<NUNumberSetting min:0 max:1 attributes:{\\n    required = 1;\\n}>\";\n    saturation = \"<NUNumberSetting min:-100 max:100 attributes:{\\n    default = 0;\\n    required = 1;\\n}>\";\n    spread = \"<NUNumberSetting min:0 max:2 attributes:{\\n    default = 1;\\n    required = 1;\\n}>\";\n} attributes:{\n}> attributes:{\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
}
sourceSelect = {
    inputImage = "<NUEnumSetting values:(\n    primary,\n    spatialOvercapture,\n    spatialOvercaptureFused\n) attributes:{\n}>";
}
apertureRedEye = {
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    inputCorrectionInfo = "<NUArraySetting content:<NUCompoundSetting properties:{\n    pointX = \"<NUNumberSetting min:-999999999 max:999999999 attributes:{\\n}>\";\n    pointY = \"<NUNumberSetting min:-999999999 max:999999999 attributes:{\\n}>\";\n    radius = \"<NUNumberSetting min:0 max:999999999 attributes:{\\n}>\";\n    sensitivity = \"<NUNumberSetting min:0 max:1 attributes:{\\n}>\";\n} attributes:{\n}> attributes:{\n    required = 0;\n}>";
}
depthEffect = {
    aperture = "<NUNumberSetting min:0.8 max:22 attributes:{\n    required = 0;\n}>";
    depthInfo = "<NUOpaqueSetting attributes:{\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
}
smartColor = {
    auto = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    inputCast = "<NUNumberSetting min:-1 max:2 attributes:{\n    default = 0;\n}>";
    inputColor = "<NUNumberSetting min:-1 max:1 attributes:{\n    default = 0;\n}>";
    inputContrast = "<NUNumberSetting min:-1 max:2 attributes:{\n    default = 0;\n}>";
    inputSaturation = "<NUNumberSetting min:-1 max:2 attributes:{\n    default = 0;\n}>";
    offsetCast = "<NUNumberSetting min:-1 max:2 attributes:{\n    default = 0;\n}>";
    offsetContrast = "<NUNumberSetting min:-2 max:2 attributes:{\n    default = 0;\n}>";
    offsetSaturation = "<NUNumberSetting min:-2 max:2 attributes:{\n    default = 0;\n}>";
    statistics = "<NUOpaqueSetting attributes:{\n    required = 0;\n}>";
}
portraitEffect = {
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    kind = "<NUEnumSetting values:(\n    Light,\n    Commercial,\n    Contour,\n    Black,\n    BlackoutMono,\n    StudioV2,\n    ContourV2,\n    StageV2,\n    StageMonoV2,\n    StageWhite\n) attributes:{\n    default = Light;\n}>";
    portraitInfo = "<NUOpaqueSetting attributes:{\n}>";
    strength = "<NUNumberSetting min:0 max:1 attributes:{\n    required = 0;\n}>";
    version = "<NUNumberSetting min:0 max:1 attributes:{\n    required = 0;\n}>";
}
raw = {
    inputDecoderVersion = "<NUOpaqueSetting attributes:{\n}>";
    inputSushiLevel = "<NUOpaqueSetting attributes:{\n    required = 0;\n}>";
}
trim = {
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    end = "<NUNumberSetting min:0 max:9223372036854775807 attributes:{\n}>";
    endScale = "<NUNumberSetting min:1 max:2147483647 attributes:{\n}>";
    start = "<NUNumberSetting min:0 max:9223372036854775807 attributes:{\n}>";
    startScale = "<NUNumberSetting min:1 max:2147483647 attributes:{\n}>";
}
effect = {
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    intensity = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 1;\n    required = 0;\n}>";
    kind = "<NUEnumSetting values:(\n    Mono,\n    Tonal,\n    Noir,\n    Fade,\n    Chrome,\n    Process,\n    Transfer,\n    Instant\n) attributes:{\n    default = Mono;\n}>";
    version = "<NUNumberSetting min:0 max:2 attributes:{\n    required = 0;\n}>";
}
slomo = {
    end = "<NUNumberSetting min:0 max:9223372036854775807 attributes:{\n}>";
    endScale = "<NUNumberSetting min:1 max:2147483647 attributes:{\n}>";
    rate = "<NUNumberSetting min:0.01 max:1 attributes:{\n}>";
    start = "<NUNumberSetting min:0 max:9223372036854775807 attributes:{\n}>";
    startScale = "<NUNumberSetting min:1 max:2147483647 attributes:{\n}>";
}
grain = {
    amount = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 0;\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    iso = "<NUNumberSetting min:10 max:3200 attributes:{\n    default = 800;\n}>";
    seed = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 0;\n    required = 0;\n}>";
}
videoReframe = {
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    keyframes = "<NUArraySetting content:<NUCompoundSetting properties:{\n    homography = \"<NUArraySetting content:<NUNumberSetting min:-9223372036854775807 max:9223372036854775807 attributes:{\\n    default = 0;\\n}> attributes:{\\n}>\";\n    timeScale = \"<NUNumberSetting min:1 max:2147483647 attributes:{\\n}>\";\n    timeValue = \"<NUNumberSetting min:-9223372036854775807 max:9223372036854775807 attributes:{\\n}>\";\n} attributes:{\n}> attributes:{\n}>";
    stabCropRect = "<NUCompoundSetting properties:{\n    Height = \"<NUNumberSetting min:-999999999 max:999999999 attributes:{\\n    default = 0;\\n}>\";\n    Width = \"<NUNumberSetting min:-999999999 max:999999999 attributes:{\\n    default = 0;\\n}>\";\n    X = \"<NUNumberSetting min:-999999999 max:999999999 attributes:{\\n    default = 0;\\n}>\";\n    Y = \"<NUNumberSetting min:-999999999 max:999999999 attributes:{\\n    default = 0;\\n}>\";\n} attributes:{\n}>";
}
rawNoiseReduction = {
    auto = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
    color = "<NUNumberSetting min:-1 max:1 attributes:{\n    default = 0;\n}>";
    contrast = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 0;\n    required = 0;\n}>";
    detail = "<NUNumberSetting min:0 max:3 attributes:{\n    default = 0;\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    luminance = "<NUNumberSetting min:-0.1 max:1 attributes:{\n    default = 0;\n}>";
    sharpness = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 0;\n    required = 0;\n}>";
}
cropStraighten = {
    angle = "<NUNumberSetting min:-45 max:45 attributes:{\n    default = 0;\n}>";
    auto = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
    constraintHeight = "<NUNumberSetting min:0 max:999999999 attributes:{\n    required = 0;\n}>";
    constraintWidth = "<NUNumberSetting min:0 max:999999999 attributes:{\n    required = 0;\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    height = "<NUNumberSetting min:-999999999 max:999999999 attributes:{\n    default = 0;\n}>";
    originalCrop = "<NUBoolSetting attributes:{\n    default = 0;\n    required = 0;\n}>";
    pitch = "<NUNumberSetting min:-30 max:30 attributes:{\n    default = 0;\n    required = 0;\n}>";
    smart = "<NUBoolSetting attributes:{\n    default = 0;\n    required = 0;\n}>";
    width = "<NUNumberSetting min:-999999999 max:999999999 attributes:{\n    default = 0;\n}>";
    xOrigin = "<NUNumberSetting min:-999999999 max:999999999 attributes:{\n    default = 0;\n}>";
    yOrigin = "<NUNumberSetting min:-999999999 max:999999999 attributes:{\n    default = 0;\n}>";
    yaw = "<NUNumberSetting min:-30 max:30 attributes:{\n    default = 0;\n    required = 0;\n}>";
}
highResFusion = {
    alignment = "<NUOpaqueSetting attributes:{\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
}
sharpen = {
    auto = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
    edges = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 1;\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    falloff = "<NUNumberSetting min:0 max:1 attributes:{\n    default = 1;\n}>";
    intensity = "<NUNumberSetting min:0 max:2 attributes:{\n    default = 0;\n}>";
}
autoLoop = {
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    flavor = "<NUEnumSetting values:(\n    AutoLoop,\n    Mirror,\n    LongExposure\n) attributes:{\n    default = AutoLoop;\n}>";
    recipe = "<NUOpaqueSetting attributes:{\n}>";
}
retouch = {
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    inputStrokes = "<NUArraySetting content:<NUCompoundSetting properties:{\n    mode = \"<NUEnumSetting values:(\\n    Repair\\n) attributes:{\\n}>\";\n    opacity = \"<NUNumberSetting min:0 max:1 attributes:{\\n}>\";\n    points = \"<NUArraySetting content:<NUCompoundSetting properties:{\\n    pressure = \\\"<NUNumberSetting min:0 max:1 attributes:{\\\\n    required = 0;\\\\n}>\\\";\\n    x = \\\"<NUNumberSetting min:-9223372036854775808 max:9223372036854775807 attributes:{\\\\n}>\\\";\\n    y = \\\"<NUNumberSetting min:-9223372036854775808 max:9223372036854775807 attributes:{\\\\n}>\\\";\\n} attributes:{\\n}> attributes:{\\n}>\";\n    radius = \"<NUNumberSetting min:0 max:4000 attributes:{\\n}>\";\n    repairEdges = \"<NUBoolSetting attributes:{\\n    default = 0;\\n    required = 0;\\n}>\";\n    softness = \"<NUNumberSetting min:0 max:1 attributes:{\\n}>\";\n    sourceOffset = \"<NUCompoundSetting properties:{\\n    x = \\\"<NUNumberSetting min:-9223372036854775808 max:9223372036854775807 attributes:{\\\\n}>\\\";\\n    y = \\\"<NUNumberSetting min:-9223372036854775808 max:9223372036854775807 attributes:{\\\\n}>\\\";\\n} attributes:{\\n}>\";\n    version = \"<NUNumberSetting min:1 max:10000 attributes:{\\n}>\";\n} attributes:{\n}> attributes:{\n    required = 0;\n}>";
}
smartTone = {
    auto = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
    enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
    inputBlack = "<NUNumberSetting min:-10 max:10 attributes:{\n    default = 0;\n}>";
    inputBrightness = "<NUNumberSetting min:-10 max:10 attributes:{\n    default = 0;\n}>";
    inputContrast = "<NUNumberSetting min:-10 max:10 attributes:{\n    default = 0;\n}>";
    inputExposure = "<NUNumberSetting min:-10 max:10 attributes:{\n    default = 0;\n}>";
    inputHighlights = "<NUNumberSetting min:-10 max:10 attributes:{\n    default = 0;\n}>";
    inputImage = "<NUEnumSetting values:(\n    primary,\n    spatialOvercapture,\n    spatialOvercaptureFused\n) attributes:{\n    required = 0;\n}>";
    inputLight = "<NUNumberSetting min:-10 max:10 attributes:{\n    default = 0;\n}>";
    inputLocalLight = "<NUNumberSetting min:-10 max:10 attributes:{\n    default = 0;\n    required = 0;\n}>";
    inputRawHighlights = "<NUNumberSetting min:-10 max:10 attributes:{\n    default = 0;\n}>";
    inputShadows = "<NUNumberSetting min:-10 max:10 attributes:{\n    default = 0;\n}>";
    offsetBlack = "<NUNumberSetting min:-2 max:2 attributes:{\n    default = 0;\n}>";
    offsetBrightness = "<NUNumberSetting min:-2 max:2 attributes:{\n    default = 0;\n}>";
    offsetContrast = "<NUNumberSetting min:-2 max:2 attributes:{\n    default = 0;\n}>";
    offsetExposure = "<NUNumberSetting min:-2 max:2 attributes:{\n    default = 0;\n}>";
    offsetHighlights = "<NUNumberSetting min:-2 max:2 attributes:{\n    default = 0;\n}>";
    offsetLocalLight = "<NUNumberSetting min:-2 max:2 attributes:{\n    default = 0;\n    required = 0;\n}>";
    offsetShadows = "<NUNumberSetting min:-2 max:2 attributes:{\n    default = 0;\n}>";
    overcaptureStatistics = "<NUOpaqueSetting attributes:{\n    required = 0;\n}>";
    statistics = "<NUOpaqueSetting attributes:{\n    required = 0;\n}>";
}

```

## Debugging

Raw notes/output from poking at things in the debugger

### PHPhotoLibrary

```
(lldb) po [PHPhotoLibrary.self performSelector:@selector(PHObjectClassesByEntityName)]
{
    Album = PHAssetCollection;
    Asset = PHAsset;
    CloudSharedAlbum = PHCloudSharedAlbum;
    DetectedFace = PHFace;
    DetectedFaceGroup = PHFaceGroup;
    FaceCrop = PHFaceCrop;
    FetchingAlbum = PHAssetCollection;
    Folder = PHCollectionList;
    GenericAsset = PHAsset;
    ImportSession = PHImportSession;
    Keyword = PHKeyword;
    LegacyFaceAlbum = PHAssetCollection;
    Memory = PHMemory;
    Moment = PHMoment;
    MomentList = PHMomentList;
    MomentShare = PHMomentShare;
    MomentShareParticipant = PHMomentShareParticipant;
    Person = PHPerson;
    PhotoStreamAlbum = PHAssetCollection;
    PhotosHighlight = PHPhotosHighlight;
    ProjectAlbum = PHProject;
    Question = PHQuestion;
    Suggestion = PHSuggestion;
}
```

### Adjustments

Notes:
* `val` is the "composition" entry from the `-adjustmentsDebugMetadata` dictionary for a `PHAsset`.
* suspect the `me.neilpa.photohack` instead of `com.apple.photos` for most namesaces is from the dynamic loading of arbitrary `*.photoslibrary`

Given an asset that has adjustments, it appears straightforward to decode. 

```
(lldb) po [val class]
NUGenericComposition

(lldb) po [val contents]
{
    cropStraighten = "<NUGenericAdjustment:0x10063a740> id=me.neilpa.photohack:CropStraighten~1.0 settings={\n    angle = \"-0\";\n    auto = 0;\n    constraintHeight = 0;\n    constraintW...";
    orientation = "<NUGenericAdjustment:0x10063aa70> id=me.neilpa.photohack:Orientation~1.0 settings={\n    value = 1;\n}";
    raw = "<NUGenericAdjustment:0x10063a4e0> id=me.neilpa.photohack:RAW~1.0 settings={\n    auto = 0;\n    enabled = 1;\n    inputDecoderVersion = 8;\n}";
}

(lldb) po [[val contents] objectForKey:@"cropStraighten"]
<NUGenericAdjustment:0x10063a740> id=me.neilpa.photohack:CropStraighten~1.0 settings={
    angle = "-0";
    auto = 0;
    constraintHeight = 0;
    constraintWidth = 0;
    enabled = 1;
    height = 988;
    width = 1482;
    xOrigin = 2342;
    yOrigin = 1127;
}

(lldb)  po [[[[val contents] objectForKey:@"cropStraighten"] schema] class]
NUAdjustmentSchema

(lldb) po [[[[val contents] objectForKey:@"cropStraighten"] schema] settings]
{
   angle = "<NUNumberSetting min:-45 max:45 attributes:{\n    default = 0;\n}>";
   auto = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
   constraintHeight = "<NUNumberSetting min:0 max:999999999 attributes:{\n    required = 0;\n}>";
   constraintWidth = "<NUNumberSetting min:0 max:999999999 attributes:{\n    required = 0;\n}>";
   enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
   height = "<NUNumberSetting min:-999999999 max:999999999 attributes:{\n    default = 0;\n}>";
   originalCrop = "<NUBoolSetting attributes:{\n    default = 0;\n    required = 0;\n}>";
   pitch = "<NUNumberSetting min:-30 max:30 attributes:{\n    default = 0;\n    required = 0;\n}>";
   smart = "<NUBoolSetting attributes:{\n    default = 0;\n    required = 0;\n}>";
   width = "<NUNumberSetting min:-999999999 max:999999999 attributes:{\n    default = 0;\n}>";
   xOrigin = "<NUNumberSetting min:-999999999 max:999999999 attributes:{\n    default = 0;\n}>";
   yOrigin = "<NUNumberSetting min:-999999999 max:999999999 attributes:{\n    default = 0;\n}>";
   yaw = "<NUNumberSetting min:-30 max:30 attributes:{\n    default = 0;\n    required = 0;\n}>";
}
```

The composition also has a schema which seems to expose the entire array of possible adjustments. E.g, for
every key in the `-contents` dictionary of an `NUCompositionSchema`, the associated adjustment schema
can be looked up with `[[schema modelForProperty:key] settings]`.

```objective-c
#define dump(fmt, ...) CFShow((__bridge CFStringRef)[NSString stringWithFormat:fmt, ##__VA_ARGS__])

id compSchema = [composition performSelector:@selector(schema)];
for (NSString *key in [compSchema contents]) {
    id adjSchema = ((id (*)(id, SEL, id))objc_msgSend)(compSchema, @selector(modelForProperty:), key);
    if (![adjSchema respondsToSelector:@selector(settings)]) {
        continue; // NUSourceSchema
    }
    dump(@"%@ = %@", key, [adjSchema settings]);
}
```


```
(lldb) po [[val schema] class]
NUCompositionSchema

(lldb) po [[val schema] contents]
{
   apertureRedEye = "me.neilpa.photohack:ApertureRedEye~1.0";
   autoLoop = "me.neilpa.photohack:AutoLoop~1.0";
   cropStraighten = "me.neilpa.photohack:CropStraighten~1.0";
   curves = "me.neilpa.photohack:Curves~1.0";
   definition = "me.neilpa.photohack:Definition~1.0";
   depthEffect = "me.neilpa.photohack:DepthEffect~1.0";
   effect = "me.neilpa.photohack:Effect~1.0";
   effect3D = "me.neilpa.photohack:Effect3D~1.0";
   grain = "me.neilpa.photohack:Grain~1.0";
   highResFusion = "me.neilpa.photohack:HighResolutionFusion~1.0";
   levels = "me.neilpa.photohack:Levels~1.0";
   livePhotoKeyFrame = "me.neilpa.photohack:LivePhotoKeyFrame~1.0";
   mute = "me.neilpa.photohack:Mute~1.0";
   noiseReduction = "me.neilpa.photohack:NoiseReduction~1.0";
   orientation = "me.neilpa.photohack:Orientation~1.0";
   portraitEffect = "me.neilpa.photohack:PortraitEffect~1.0";
   raw = "me.neilpa.photohack:RAW~1.0";
   rawNoiseReduction = "me.neilpa.photohack:RawNoiseReduction~1.0";
   redEye = "me.neilpa.photohack:RedEye~1.0";
   reference = "com.apple.photo:Source~1.0";
   retouch = "me.neilpa.photohack:Retouch~1.0";
   selectiveColor = "me.neilpa.photohack:SelectiveColor~1.0";
   sharpen = "me.neilpa.photohack:Sharpen~1.0";
   slomo = "me.neilpa.photohack:SlowMotion~1.0";
   smartBlackAndWhite = "me.neilpa.photohack:SmartBlackAndWhite~1.0";
   smartColor = "me.neilpa.photohack:SmartColor~1.0";
   smartTone = "me.neilpa.photohack:SmartTone~1.0";
   source = "com.apple.photo:Source~1.0";
   sourceSelect = "me.neilpa.photohack:SourceSelect~1.0";
   sourceSpatialOvercapture = "com.apple.photo:Source~1.0";
   trim = "me.neilpa.photohack:Trim~1.0";
   videoPosterFrame = "me.neilpa.photohack:VideoPosterFrame~1.0";
   videoReframe = "me.neilpa.photohack:VideoReframe~1.0";
   vignette = "me.neilpa.photohack:Vignette~1.0";
   whiteBalance = "me.neilpa.photohack:WhiteBalance~1.0";
}

(lldb) po [[val schema] requiredContents]
{(
   source
)}


(lldb) po [[val schema] schemaDependencies]
<__NSArrayI 0x100567a80>(
NUIdentifier ns:me.neilpa.photohack name:Effect3D version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:LivePhotoKeyFrame version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:Mute version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:WhiteBalance version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:Vignette version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:Definition version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:Levels version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:VideoPosterFrame version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:RedEye version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:SmartBlackAndWhite version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:Orientation version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:Curves version:1.0>,
NUIdentifier ns:com.apple.photo name:Source version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:NoiseReduction version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:SelectiveColor version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:SourceSelect version:1.0>,
NUIdentifier ns:com.apple.photo name:Source version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:ApertureRedEye version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:DepthEffect version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:SmartColor version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:PortraitEffect version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:RAW version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:Trim version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:Effect version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:SlowMotion version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:Grain version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:VideoReframe version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:RawNoiseReduction version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:CropStraighten version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:HighResolutionFusion version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:Sharpen version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:AutoLoop version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:Retouch version:1.0>,
NUIdentifier ns:com.apple.photo name:Source version:1.0>,
NUIdentifier ns:me.neilpa.photohack name:SmartTone version:1.0>
)

(lldb) po [[[val schema] modelForProperty:@"whiteBalance"] class]
NUAdjustmentSchema

(lldb) po [[[val schema] modelForProperty:@"whiteBalance"] settings]
{
   auto = "<NUBoolSetting attributes:{\n    required = 0;\n}>";
   colorType = "<NUEnumSetting values:(\n    neutralGray,\n    faceBalance,\n    tempTint,\n    warmTint\n) attributes:{\n    default = faceBalance;\n}>";
   enabled = "<NUBoolSetting attributes:{\n    default = 0;\n}>";
   faceI = "<NUNumberSetting min:-3 max:3 attributes:{\n    required = 0;\n}>";
   faceQ = "<NUNumberSetting min:-2 max:2 attributes:{\n    required = 0;\n}>";
   faceStrength = "<NUNumberSetting min:-3 max:3 attributes:{\n    required = 0;\n}>";
   faceWarmth = "<NUNumberSetting min:-3 max:3 attributes:{\n    required = 0;\n}>";
   grayI = "<NUNumberSetting min:-3 max:3 attributes:{\n    required = 0;\n}>";
   grayQ = "<NUNumberSetting min:-3 max:3 attributes:{\n    required = 0;\n}>";
   grayStrength = "<NUNumberSetting min:-3 max:3 attributes:{\n    default = 1;\n    required = 0;\n}>";
   grayWarmth = "<NUNumberSetting min:-3 max:3 attributes:{\n    required = 0;\n}>";
   grayY = "<NUNumberSetting min:-3 max:3 attributes:{\n    required = 0;\n}>";
   temperature = "<NUNumberSetting min:1000 max:32000 attributes:{\n    default = 5000;\n    identity = 5000;\n    required = 0;\n}>";
   tint = "<NUNumberSetting min:-150 max:150 attributes:{\n    default = 0;\n    required = 0;\n}>";
   warmFace = "<NUBoolSetting attributes:{\n    default = 0;\n    required = 0;\n}>";
   warmTemp = "<NUNumberSetting min:-2 max:2 attributes:{\n    default = 0;\n    required = 0;\n}>";
   warmTint = "<NUNumberSetting min:-2 max:2 attributes:{\n    default = 0;\n    required = 0;\n}>";
}
```
