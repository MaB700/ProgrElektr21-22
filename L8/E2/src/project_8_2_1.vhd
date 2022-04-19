library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity LIFO is
    generic (
        AWIDTH : integer := 8;
        DWIDTH : integer := 8
    );
    port (
        CLK : in std_logic;

        WEN : in std_logic; -- enable input
        DIN : in std_logic_vector(DWIDTH - 1 downto 0); -- DWIDTH bit's input

        REN : in std_logic; -- enable output
        DOUT : out std_logic_vector(DWIDTH - 1 downto 0); -- output bits from LIFO

        -- flags
        DACK : out std_logic;
        EMPTY : out std_logic;
        FULL : out std_logic;
        OVERFLOW : out std_logic;
        UNDERFLOW : out std_logic;
        DV : out std_logic
    );
end LIFO;

architecture Behavioral of LIFO is
    type ram_type is array (0 to 2 ** AWIDTH - 1) of std_logic_vector(DWIDTH - 1 downto 0);
    signal ram : ram_type;
    signal current_index : integer range 0 to 2 ** AWIDTH := 0; -- where to write next index (write index)
    signal s_full, s_empty : std_logic;
begin

    s_full <= '1' when (current_index = 2 ** AWIDTH) else -- if write index is outside of 2 ** AWIDTH - 1, its full
              '0';
    s_empty <= '1' when (current_index = 0) else -- no entries in there if write index = 0
               '0';
    
    FULL <= s_full;
    EMPTY <= s_empty;

    process (CLK) is
    begin
        if rising_edge(CLK) then
            DV <= '0';
            DACK <= '0';
            OVERFLOW <= '0';
            UNDERFLOW <= '0';

            if WEN = '1' then
                if s_full = '0' then
                    ram(current_index) <= DIN; -- write index
                    current_index <= current_index + 1; -- increment write index
                    DACK <= '1';
                else
                    OVERFLOW <= '1';
                end if;
            end if;

            if REN = '1' then
                if s_empty = '0' then
                    DOUT <= ram(current_index - 1); -- highest entry is write index - 1
                    current_index <= current_index - 1; -- decrease write index by 1 
                    DV <= '1';
                else
                    UNDERFLOW <= '1';
                end if;
            end if;

        end if;
    end process;

end Behavioral;