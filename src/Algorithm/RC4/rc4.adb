package body RC4 is
   
   procedure RC4_Swap(This: in out Object; Pos1: Byte; Pos2: Byte) is
      Aux: Byte;
   begin
      Aux := This.Internal(Pos1);
      This.Internal(Pos1) := This.Internal(Pos2);
      This.Internal(Pos2) := Aux;
   end RC4_Swap;
   
   procedure RC4_Init(This: in out Object; Key: CharVec) is
      Aux: Byte := 0;
      Aux2: Integer := 0;
      Aux3: Byte := 0;
   begin
      --Init internal state
      for I in This.Internal'Range loop
         This.Internal(I) := I;
      end loop;
   
      --Populate with key internal state
      for I in This.Internal'Range loop
         Aux2 := (Integer(I) mod Key'Length)+1;
         Aux3 := Key(Aux2);
         Aux := (Aux + Aux3 + This.Internal(I)) mod 255;
         This.RC4_Swap(Pos1 => I, Pos2 => Aux);   
      end loop;
   end RC4_Init;

   function RC4_Next(This: in out Object) return Byte is
   begin
      This.I := (This.I + 1) mod 255;
      This.J := (This.J + This.Internal(This.I)) mod 255;
      This.RC4_Swap(Pos1 => This.I, Pos2 => This.J);
      return This.Internal(This.Internal(This.I)+This.Internal(This.J));
   end RC4_Next;

end RC4;
