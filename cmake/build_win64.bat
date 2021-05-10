if not exist build.win64 mkdir build.win64

pushd build.win64

cmake -G "Visual Studio 16 2019" -A x64 ..
popd

cmake --build build.win64 --config Release
