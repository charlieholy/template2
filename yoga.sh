modify CMakeList.txt
add_compile_options(
    -fno-omit-frame-pointer
    -fexceptions
    -fvisibility=hidden
    -ffunction-sections
    -fdata-sections
    -Wall
+    -g
+    -O0
    -std=c++11)

file(GLOB_RECURSE yogacore_SRC yoga/*.cpp)
add_library(yogacore STATIC ${yogacore_SRC})
+ add_definitions(-DDEBUG -DOHOSME)

readelf -S libyogacore.a | grep debug

#include <iostream>
#include "yoga/YGNode.h"
#include "yoga/Yoga.h"
#include "yoga/log.h"
#include "yoga/YGNodePrint.h"
using namespace std;
int main() {
  cout << "begin" << endl;
  const YGNodeRef node = YGNodeNew();
  YGNodeStyleSetWidth(node,400); 
  YGNodeStyleSetHeight(node,200);//YGFlexDirectionRow
  YGNodeStyleSetFlexDirection(node,YGFlexDirectionRow);
  for (int i=0;i<4;i++){
    const YGNodeRef nodechild =YGNodeNew(); 
    YGNodeStyleSetWidth(nodechild,40);
    YGNodeStyleSetHeight(nodechild,40);
    YGNodeInsertChild(node,nodechild,i);
  }
  YGNodeCalculateLayout(node,400, 400, YGDirectionLTR);
  std::string str; 
  facebook::yoga::YGNodeToString(str, node, (YGPrintOptions)(
  YGPrintOptionsL ayoutYGPrintOptionsChildren
  YGPrintOptionsStyle), 0); 
  cout << str << endl;
  return 0;
}
g++ main.cpp -DDEBUG -Lbuild -lyogacore -fpermissive -g -O0

printinfo:
begin
<div layout="width: 400; height: 200; top: 0; left: 0;" style="flex-direction: row; width: 400px; height: 200px; " >
  <div layout="width: 40; height: 40; top: 0; left: 0;" style="width: 40px; height: 40px; " ></div>
  <div layout="width: 40; height: 40; top: 0; left: 40;" style="width: 40px; height: 40px; " ></div>
  <div layout="width: 40; height: 40; top: 0; left: 80;" style="width: 40px; height: 40px; " ></div>
  <div layout="width: 40; height: 40; top: 0; left: 120;" style="width: 40px; height: 40px; " ></div>
</div>



adb shell -x logcat -c
adb shell -x logcat | grep yoga
