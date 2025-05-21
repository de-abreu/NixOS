{pkgs, ...}: let
  gb = "${pkgs.grimblast}/bin/grimblast";
  screenshot =
    pkgs.writeShellScriptBin "screenshot"
    # bash
    ''
      outputDir="$HOME/Pictures/Screenshots/"
      outputFile="snapshot_$(date +%Y-%m-%d_%H-%M-%S).png"
      outputPath="$outputDir/$outputFile"
      mkdir -p "$outputDir"

      mode=''${1:-area}

      case "$mode" in
      active)
          command="${gb} copysave active $outputPath"
          ;;
      output)
          command="${gb} copysave output $outputPath"
          ;;
      area)
          command="${gb} copysave area $outputPath"
          ;;
      *)
          echo "Invalid option: $mode"
          echo "Usage: $0 {active|output|area}"
          exit 1
          ;;
      esac

      if eval "$command"; then
          recentFile=$(find "$outputDir" -name 'snapshot_*.png' -printf '%T+ %p\n' | sort -r | head -n 1 | cut -d' ' -f2-)
          notify-send "Grimblast" "Your snapshot has been saved." \
              -i video-x-generic \
              -a "Grimblast" \
              -t 7000 \
              -u normal \
              --action="scriptAction:-xdg-open $outputDir=Directory" \
              --action="scriptAction:-xdg-open $recentFile=View"
      fi
    '';
in {
  home.packages = [screenshot];
}
