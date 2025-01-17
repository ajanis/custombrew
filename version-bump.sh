#!/bin/bash
# shellcheck disable=SC2068

# Log Vars
lR='\033[31m'
lG='\033[32m'
lY='\033[33m'
lB='\033[34m'
lW='\033[0m'

# GitHub CLI
which gh || brew install gh

# Functions
function xc() { # Logging
    echo -e "$@"
}
xc "$lW"
function versionReadme() { # ReadMe
    xc "${lY}Select a version release to increment.  Options are:

  ${lW}['1' or 'major']:   ${lB}Major version release. (Ex. 3.0.0 => 4.0.0)
  ${lW}['2' or 'minor']:   ${lB}Minor point release. (Ex. 4.0.0 => 4.1.0)
  ${lW}['3' or 'patch']:   ${lB}Patch version release. (Ex. 4.1.0 => 4.1.1)"
}

# Formula Files
formulaArray+=("$(find . -name '*.rb')")

# Build Dict from formula files
item=1

for formulaItem in ${formulaArray[@]}; do
    formulaFileDict[item]=$formulaItem
    formulaDict[item]=$(basename "${formulaItem}" | cut -d '.' -f1)
    ((item++))
done

# Create key: value selection menu of detected Formula files
xc "${lY}Select Homebrew Formula ID (Ex. '1')...
${lW}"
for choice in ${!formulaFileDict[@]}; do
    xc "  ${lW}[$choice] : ${lB}${formulaFileDict[${choice}]}"
done

xc "${lY}"

# Read Formula selection
read -rp "Selection : " choice
export formulaName=${formulaDict[$choice]}
export formulaFile=${formulaFileDict[$choice]}
# formulaBase=$(basename "${formulaFile}")
# export formulaBase=$formulaBase
# formulaName=$(echo "${formulaBase}" | cut -d '.' -f1)
# export formulaName=$formulaName
echo -e "
Formula Name: $formulaName
Formula File: $formulaFile
"
xc "${lB}
Incrementing version for $formulaName ...
${lW}"

# Match version string in selected Formula file
curVersion="$(git -C "${formulaName}" describe --tags --abbrev=0 | tr -d 'v')"
# curVersion=$(sed -E -n '/version/s/^.+([0-9]\.[0-9]\.[0-9]).+$/\1/p' "${formulaFile}")
export curVersion="${curVersion}"
# Create an array of 'release bits' from the detected version using '.' as the delimiter
versionBits=(${curVersion//./ })

# Print instructions for selecting a release bit to increment
versionReadme

# Read the selected relalease type
xc "${lY}"
read -rp "Version Release Choice : " versionChoice

# Match the selected release type to a menu item.
# Using the previously created 'version array', increment the corresponding 'release bit'
case $versionChoice in
major | 1)
    export versionLevel="major"
    ((versionBits[0]++))
    newVersion="${versionBits[0]}.0.0"
    ;;
minor | 2)
    export versionLevel="minor"
    ((versionBits[1]++))
    newVersion="${versionBits[0]}.${versionBits[1]}.0"
    ;;
patch | 3)
    export versionLevel="patch"
    ((versionBits[2]++))
    newVersion="${versionBits[0]}.${versionBits[1]}.${versionBits[2]}"
    ;;
*)
    versionReadme
    ;;
esac

# Reassemble the version string
export newVersion="${newVersion}"

xc "${lG}
Previous Version: ${curVersion}
New Version: ${newVersion}
"

cd "${formulaName}" || exit
xc "${lB}Tag and Push ${formulaName} repository
${lW}"
sed -e 
git commit -q -am "Ensuring Commit..."
git checkout -q -f
xc "${lB}
Tagging Git repository...
${lW}"
git tag -a "v${newVersion}" -m "${versionLevel} revision : v${newVersion}"
xc "${lB}Pushing Repository and Tags...
${lW}"
git push --all
git push --tags -f

xc "${LB}
Preparing Release...
${LW}"
mkdir -p archive
tarFile="v${newVersion}.tar.gz"
tarPath="archive/${tarFile}"
export tarFile="${tarFile}"
export tarPath="${tarPath}"
xc "${lB}Creating Archive: ${tarPath}
${LW}"
tar -czf "${tarPath}" "${formulaName}"
archiveSHA=$(shasum -a 256 "${tarPath}" | awk '{print $1}')
export archiveSHA="${archiveSHA}"

# Display SHA256 Sum, Previous Version and New Version
xc "${lG}SHA256 Sum of ${tarFile} : $archiveSHA
${lW}"
xc "${lB}Publishing Git Release : v${newVersion}
${lW}"
gh release create v"${newVersion}" --generate-notes "${tarPath}"
cd ..

xc "${lB}
Updating version v${curVersion} to v${newVersion} in ${formulaFile}
${lW}"
sed -i '' "s/$curVersion/$newVersion/g" "${formulaFile}"

xc "${lB}Updating SHA256 Sum in ${formulaFile}
${lW}"
sed -i '' -E "/sha256/s/^(.+sha256).*$/\1 \"${archiveSHA}\"/" "${formulaFile}"

xc "${lB}Commit and push changes to Tap repository
${lW}"
git commit -q -am "Updating ${formulaName} to version v${newVersion}"
git push --all -q

xc "${lG}
Done
${lW}"
