library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity ram is
    generic (
        AWIDTH : integer := 8; -- 2^AWIDTH elements in ram of some type (std_logic_vector in out case)
        DWIDTH : integer := 8 -- std_logic_vector length
    );
    port (
        CLK : in std_logic;

        WEN : in std_logic; -- enable input
        WADD : in std_logic_vector(AWIDTH - 1 downto 0); -- write adress Nr.
        DIN : in std_logic_vector(DWIDTH - 1 downto 0); -- DWIDTH bit's input

        REN : in std_logic; -- enable output
        RADD : in std_logic_vector(AWIDTH - 1 downto 0); -- read adress nr.
        DOUT : out std_logic_vector(DWIDTH - 1 downto 0) -- output bits from ram(read adressNr) 
    );
end ram;

architecture Behavioral of ram is
    type ram_type is array (0 to 2 ** AWIDTH - 1) of std_logic_vector(DWIDTH - 1 downto 0);
    signal ram : ram_type;
begin
    process (CLK) is
    begin
        if rising_edge(CLK) then
            
            if WEN = '1' then
                ram(to_integer(unsigned(WADD))) <= DIN; -- write into ram at WADD adress Nr.
            end if;

            if REN = '1' then
                DOUT <= ram(to_integer(unsigned(RADD))); -- read from ram at RADD adress Nr.
            end if;

        end if;
    end process;

end Behavioral;