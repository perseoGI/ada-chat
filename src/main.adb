with Ada.Text_IO; use Ada.Text_IO;
with RC4;
--with "./utils/utils";

with Utils;

procedure Main is
	Input, Output: File_Type;
	Line: String(1..10);
	Assert: Boolean;
begin
	--Create(File => Output,
	--Mode => Out_File,
	--Name => "adachat.cfg");

	--Put_Line(Output, "1234567890");

	--Close(Output);

	Open(File => Input,
	Mode => In_File,
	Name => "adachat.cfg");

	Line := Get_Line(Input);
	Close(Input);
	--Put_Line(Line);

	Assert := utils.Is_String_IpV4("192.168.1.1");

	utils.Is_String_IpV4_Test;

	--Put_Line("Hola Mundo");
end Main;
