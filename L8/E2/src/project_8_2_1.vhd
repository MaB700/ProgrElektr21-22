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
    signal current_index : integer range 0 to 2**AWIDTH-1 := 0;
    signal s_full, s_empty : std_logic;
begin
    
s_full <= '1' when (current_index = 2**AWIDTH-1) else '0';
s_empty <= '1' when (current_index = 0) else '0';
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
                    ram(current_index) <= DIN; --to_integer(unsigned(WADD))
                    current_index <= current_index + 1;                    
                    DACK <= '1';
                else
                    OVERFLOW <= '1';
                end if;
            end if;
            
            if REN = '1' then
                DOUT <= ram(current_index);
                if s_empty = '0' then                    
                    current_index <= current_index - 1;
                    DV <= '1';
                else
                    UNDERFLOW <= '1';
                end if;
            end if;
            
        end if;
    end process;

end Behavioral;
