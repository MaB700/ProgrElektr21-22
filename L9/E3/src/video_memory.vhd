library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity ram_init is
    port (
    CLK : in std_logic ;
    WEN : in std_logic ;
    REN : in std_logic ;
    WADD : in std_logic_vector(9 downto 0);
    RADD : in std_logic_vector(9 downto 0);
    DIN : in std_logic_vector(1599 downto 0);
    DOUT : out std_logic_vector(1599 downto 0)
    );
end entity ram_init;

architecture behavioral of ram_init is
    type ram_type is array (0 to 899)
            of std_logic_vector(1599 downto 0);

        impure function init_ram ( fname : string ) return ram_type is
            file data_file : text is in fname ;
            variable data_line : line ;
            variable ram_i : ram_type ;
            variable bit_word : bit_vector ( ram_i (0) ' range );
        begin
            for nline in ram_type ' range loop
                readline ( data_file , data_line ) ;
                read ( data_line , bit_word ) ;
                ram_i ( nline ) := to_stdlogicvector ( bit_word );
            end loop ;
        return ram_i ;
    end function init_ram ;

    signal ram : ram_type := init_ram ("test.dat");

begin
    process ( CLK ) is
        begin
        if rising_edge ( CLK ) then
            if WEN = '1' then
                ram ( to_integer( unsigned(WADD))) <= DIN ;
            end if ;
                if REN = '1' then
            DOUT <= ram ( to_integer( unsigned(RADD)));
        end if ;
        end if ;
    end process ;
end architecture behavioral ;