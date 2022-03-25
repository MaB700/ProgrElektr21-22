library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity ram is
    generic (
        AWIDTH : integer := 8;
        DWIDTH : integer := 8
    );    
    Port ( 
        CLK : in std_logic;
        
        WEN : in std_logic; -- enable input
        --WADD : in std_logic_vector(AWIDTH-1 downto 0); -- adress Nr.
        DIN : in std_logic_vector(DWIDTH-1 downto 0); -- DWIDTH bit's input
        
        REN : in std_logic; -- enable output
        --RADD : in std_logic_vector(AWIDTH-1 downto 0); -- adress nr.
        DOUT : out std_logic_vector(DWIDTH-1 downto 0); -- output bits from ram(adressNr) 
        
        -- flags
        DACK : out std_logic;
        EMPTY : out std_logic;
        FULL : out std_logic;
        OVERFLOW : out std_logic;
        UNDERFLOW : out std_logic;
        DV : out std_logic
    );
end ram;

architecture Behavioral of ram is
    type ram_type is array (0 to 2**AWIDTH-1) of std_logic_vector(DWIDTH-1 downto 0);
    signal ram : ram_type;
    signal front_index : integer range 0 to 2**AWIDTH-1 := 0;
    signal end_index : integer range 0 to 2**AWIDTH-1 := 0;
    signal index_diff : integer range 0 to 2**AWIDTH-1 := 0;
    signal s_full, s_empty : std_logic;
    signal is_full : std_logic := '0';
    signal is_empty : std_logic := '1';
begin
index_diff <= front_index - end_index;  -- 
s_full <= '1' when (index_diff = 0) and is_full = '1' and is_empty = '0' else '0';
s_empty <= '1' when (index_diff = 0) and is_full = '0' and is_empty = '1' else '0';
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
                    ram(end_index) <= DIN; -- ram(end_queue_index)
                    end_index <= end_index + 1;
                    if end_index = 255 then
                        end_index <= 0;
                    end if;
                    if index_diff = 1 then
                        is_full <= '1';                        
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
                    if front_index = 255 then
                        front_index <= 0;
                    end if;
                    if index_diff = -1 then
                        is_empty <= '1';
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
