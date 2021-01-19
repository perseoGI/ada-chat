with Ada.Strings.Bounded;
package File_Parser is
    package IPv4 is new Ada.Strings.Bounded.Generic_Bounded_Length(15); use IPv4;

    procedure Parse_Config_File(Ip_Dest: out IPv4.Bounded_String; Port_Dest: out Positive; Port_Src: out Positive);

end File_Parser;
