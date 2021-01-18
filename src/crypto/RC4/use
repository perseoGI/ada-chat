with Ada.Text_IO;
with RC4;

procedure Main is
   use Ada.Text_IO;
   use RC4;

   Key : CharVec := (211,210,101,4,7,9);
   Msg : String := "Esto es una prueba xdddddddddddddddddasdasdasdas";
   Aux: Byte;
   RC4_Chiper,RC4_Dechiper : RC4.Object;

begin
   --Cifrar
   Put_Line("Ciframos...");
   RC4_Chiper.RC4_Init(Key => Key);
   Put_Line(Msg);

   for Elem in Msg'Range loop
      Aux := Byte(Character'Pos(Msg(Elem)));
      Msg(Elem) := Character'Val(Aux xor RC4_Chiper.RC4_Next);
   end loop;

   --Mensaje cifrado
   Put_Line(Msg);

   --Descifrar
   Put_Line("Desciframos...");
   RC4_Dechiper.RC4_Init(Key => Key);

   for Elem in Msg'Range loop
      Aux := Byte(Character'Pos(Msg(Elem)));
      Msg(Elem) := Character'Val(Aux xor RC4_Dechiper.RC4_Next);
   end loop;
   Put_Line(Msg);

end;
