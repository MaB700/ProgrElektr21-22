library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity FIFO is
    generic (
        AWIDTH : integer := 8;
        DWIDTH : integer := 8
    );
    port (
        CLK : in std_logic;

        WEN : in std_logic; -- enable input
        DIN : in std_logic_vector(DWIDTH - 1 downto 0); -- DWIDTH bit's input

        REN : in std_logic; -- enable output
        DOUT : out std_logic_vector(DWIDTH - 1 downto 0); -- output bits from ram(adressNr) 

        -- flags
        DACK : out std_logic;
        EMPTY : out std_logic;
        FULL : out std_logic;
        OVERFLOW : out std_logic;
        UNDERFLOW : out std_logic;
        DV : out std_logic
    );
end FIFO;

architecture Behavioral of FIFO is
    type ram_type is array (0 to 2 ** AWIDTH - 1) of std_logic_vector(DWIDTH - 1 downto 0);
    signal ram : ram_type;
    signal front_index : integer range 0 to 2 ** AWIDTH - 1 := 0;
    signal end_index : integer range 0 to 2 ** AWIDTH - 1 := 0;
    signal index_diff : integer range 0 to 2 ** AWIDTH - 1 := 0;
    signal s_full, s_empty : std_logic;
    signal is_full : std_logic := '0';
    signal is_empty : std_logic := '1';
begin
    index_diff <= front_index - end_index; -- 
    s_full <= '1' when (index_diff = 0) and is_full = '1' and is_empty = '0' else
              '0';
    s_empty <= '1' when (index_diff = 0) and is_full = '0' and is_empty = '1' else
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
                    ram(end_index) <= DIN;
                    end_index <= end_index + 1;
                    if end_index = 2 ** AWIDTH - 1 then -- explicit overflow, probably not needed
                        end_index <= 0;
                    end if;
                    if index_diff = 1 or index_diff = -(2 ** AWIDTH - 1) then -- check one step before it's full
                        -- special case : e.g. front_index = 0 , end_index = 255 -> index_diff=-255 
                        -- gets caught with index_diff = -(2 ** AWIDTH - 1)
                        is_full <= '1'; -- if end_index wrapped around to be now 'infront' of front_index
                    end if;
                    DACK <= '1';
                    is_empty <= '0';
                else
                    OVERFLOW <= '1';
                end if;
            end if;

            if REN = '1' then
                DOUT <= ram(front_index);
                if s_empty = '0' then
                    front_index <= front_index + 1;
                    if front_index = 2 ** AWIDTH - 1 then
                        front_index <= 0;
                    end if;
                    if index_diff = -1 or index_diff = (2 ** AWIDTH - 1) then -- check one step before it's empty
                        is_empty <= '1'; -- sign is important to know if it will be full or empty
                    end if;
                    DV <= '1';
                    is_full <= '0';
                else
                    UNDERFLOW <= '1';
                end if;
            end if;

        end if;
    end process;

end Behavioral;