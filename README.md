# genstringsStep2
A swift script can update other strings file while Base localizable.strings file changed.

用系统的genstring命令生成的strings文件在后续更新维护中非常麻烦，要增加或修改一个字段都要在所有语言的对应文件中修改，非常麻烦。用此脚本，只要在所有修改完成后，用genstring统一输出一遍Base 或 en的Strings文件，然后运行此脚本。对应的中文或其他语言的strings文件就会把Base里不存在的删掉，新增加的添加，没改动的保留下来。

目录中的 lprojw 文件夹中的文件可用于测试。

## Usage: 
####./genstringsStep2.swift ./ Base Localizable zh-Hans

## Before
###Base.lproj/Localizable.strings
"Changed" = "Changed";

"New" = "New";

"NotChanged" = "NotChanged";
###zh-Hans.lproj/Localizable.strings
"NotChanged" = "没改变的";

"Removed" = "已删除的";

"Old" = "陈旧的";

## After
###Base.lproj/Localizable.strings
"Changed" = "Changed";

"New" = "New";

"NotChanged" = "NotChanged";
###zh-Hans.lproj/Localizable.strings

"Changed"="Changed";

"New"="New";

"NotChanged"="没改变的";