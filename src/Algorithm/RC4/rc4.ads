with Ada.Numerics;
with Ada.Text_IO;

package RC4 is
   --uses
   use Ada.Text_IO;
   
   --typedefs
   type Byte is mod 256;
   type CharArr is array (Byte) of Byte;
   type CharVec is array (Positive range<>) of Byte;
   
   --datos
   type Object is tagged record
      I, J : Byte := 0;
      Internal : CharArr;
   end record;
   
   --metodos
   procedure RC4_Swap(This: in out Object; Pos1: Byte; Pos2: Byte);
   procedure RC4_Init(This: in out Object; Key: CharVec);
   function RC4_Next(This: in out Object) return Byte; 
end RC4;
