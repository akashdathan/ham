/* Generated by mkjambase from Jambase */
const char *jambase[] = {
/* Jambase */
"if ! $(HAMBASE) || $(HAMBASE) = \"\" {\n",
"HAMBASE = $(HAM_HOME)/rules/base.ham ;\n",
"}\n",
"if ! $(HAMBASE) || ! [ FExists $(HAMBASE) ] {\n",
"EXIT \"Can't find HAMBASE: \" $(HAMBASE) ;\n",
"}\n",
"include $(HAMBASE) ;\n",
0 };
