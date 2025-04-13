{ config, lib, ... }:

{
  options = {
    desktop.chromium.enable = lib.mkEnableOption "Enable chromium";
  };

  config = lib.mkIf config.desktop.chromium.enable {
    programs.chromium = {
      enable = true;
      # commandLineArgs = [
      #   "--enable-features=UseOzonePlatform"
      #   "--ozone-platform=wayland"
      #   "--enable-features=VaapiVideoDecodeLinuxGL,VaapiVideoEncoder,Vulkan,VulkanFromANGLE,DefaultANGLEVulkan,VaapiIgnoreDriverChecks,VaapiVideoDecoder,PlatformHEVCDecoderSupport,UseMultiPlaneFormatForHardwareVideo"
      # ];
      extensions = [
        { id = "ddkjiahejlhfcafbddmgiahcphecmpfh"; } # ublock origin lite
        { id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"; } # privacy badger
        { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
        { id = "bhchdcejhohfmigjafbampogmaanbfkg"; } # user-agent spoofer
        { id = "oboonakemofpalcgghocfoadofidjkkk"; } # keepassxc-browser
        { id = "aleakchihdccplidncghkekgioiakgal"; } # h264ify
      ];
    };
  };
}
