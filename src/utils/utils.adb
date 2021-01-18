with Ada.Text_IO, Ada.Containers.Indefinite_Vectors, Ada.Strings.Fixed,
	Ada.Strings.Maps, Ada.Characters.Handling, Ada.Strings.Unbounded,
	Ada.Strings.Unbounded.Text_IO;

use Ada.Text_IO, Ada.Containers, Ada.Strings, Ada.Strings.Fixed,
	Ada.Strings.Maps, Ada.Characters.Handling, Ada.Strings.Unbounded,
	Ada.Strings.Unbounded.Text_IO;

package body Utils is

	package String_Vectors is new Indefinite_Vectors (Positive, String);
	use String_Vectors;

	function String_Tokenize (Str: String; Delimiter: String) return Vector is
		Start  : Positive := Str'First;
		Finish : Natural  := 0;
		Output : Vector   := Empty_Vector;
	begin
		while Start <= Str'Last loop
			-- From is in, First and Last are out parameters
			Find_Token (Source => Str, Set => To_Set (Delimiter), From => Start,
						Test => Outside, First => Start, Last => Finish);
			exit when Start > Finish;
			Output.Append (Str (Start .. Finish));
			Start := Finish + 1;
		end loop;
		return Output;
	end String_Tokenize;


	function Is_String_IpV4(Str: String) return Boolean is
		Tokens: Vector := Empty_Vector;
		Frac: Integer;
	begin

		Tokens := String_Tokenize(Str => Str, Delimiter => ".");

		if Tokens.Length /= 4 then
			return False;
		end if;

		for Token of Tokens loop
			if Token'Length > 0 then
				for T of Token loop
					if not Is_Digit(T) then
						return False;
					end if;
				end loop;
				Frac := Integer'Value(Token);
				if Frac > 255 then
					return False;
				end if;
			end if;

		end loop;

		return True;
	end Is_String_IpV4;

	type Test_Case is record
		content: unbounded_string;
		valid: Boolean;
	end record;

	type Test_Case_Vector is array (Positive range <>) of Test_Case;

	procedure Is_String_IpV4_Test is
		Test_Values: Test_Case_Vector := (
				(To_Unbounded_String("200.32.4"), False),
				(To_Unbounded_String("12.324.53.3"), False),
				(To_Unbounded_String("12.324.53.3"), False),
				(To_Unbounded_String("192.200.23.256"), False),
				(To_Unbounded_String("-1.23.43.5"), False),
				(To_Unbounded_String("1.23.+43.5"), False),
				(To_Unbounded_String("1.23.43.5t"), False),
				(To_Unbounded_String("1.23.4a3.05"), False),
				(To_Unbounded_String("asd"), False),
				(To_Unbounded_String("a.b.d.f.g"), False),
				(To_Unbounded_String("142.24.52.5"), True),
				(To_Unbounded_String("192.200.23.23"), True),
				(To_Unbounded_String("0.0.0.0"), True),
				(To_Unbounded_String("001.023.043.05"), True)
				) ;
		Result: Boolean;
	begin
		Put_Line("Running Unit Tests for Is_String_IpV4..." & ASCII.LF);
		for TestValue of Test_Values loop
			Result := Is_String_IpV4(To_String(TestValue.content));
			Ada.Text_IO.Set_Col(4);
			if TestValue.valid /= Result then
				Put("[ERROR]  ");
			else
				Put("[ OK ]   ");
			end if;
			Ada.Text_IO.Set_Col(14);
			Put(To_String(TestValue.content));
			Ada.Text_IO.Set_Col(34);
			Put_Line(" is " & (if TestValue.valid = True then "valid" else "invalid"));
		end loop;

	end Is_String_IpV4_Test;

end Utils;
