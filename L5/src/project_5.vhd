library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity project_5 is
    Port ( 
        CLK : in std_logic;
        I : in std_logic_vector(7 downto 0);
        ENTER    : in std_logic;
        REPROGRAM: in std_logic;
        ABORT    : in std_logic;
        RESET    : in std_logic;
        C : out std_logic_vector(7 downto 0);
        A : out std_logic_vector(3 downto 0);
        LED : out std_logic_vector(3 downto 0)
    );
end project_5;

architecture Behavioral of project_5 is
signal s_enter, s_reprogram, s_abort, s_reset : std_logic := '0';
type state_type is (s1, s2, s3, check, opened, locked, aborted, error, reprogramming);
signal state : state_type := s1;
signal count : integer range 0 to 3 := 0;
-- signal err_count: integer range 0 to 3 := 0;
signal message : std_logic_vector(31 downto 0) := (others => '1');
signal mode_dis : std_logic_vector(1 downto 0) := (others => '0');
begin
    
    edge_detector_enter : entity work.edge_detector
    port map (
        CLK => CLK,
        I => ENTER,
        EDGE => s_enter
    );
    
    edge_detector_reprogram : entity work.edge_detector
    port map (
        CLK => CLK,
        I => REPROGRAM,
        EDGE => s_reprogram
    );
    
    edge_detector_abort : entity work.edge_detector
    port map (
        CLK => CLK,
        I => ABORT,
        EDGE => s_abort
    );
    
    edge_detector_reset : entity work.edge_detector
    port map (
        CLK => CLK,
        I => RESET,
        EDGE => s_reset
    );
    
    multi_display : entity work.project_4_4
    port map (
        CLK => CLK,
        I => message,
        MODE => mode_dis,
        C => C,
        A => A
    );
    -- mode -> signal ( "01" or "11" ) , binary -> hex (decimal)
    process (CLK) is
        variable code : unsigned(23 downto 0) := "000011110000111100001111"; -- first 3 switches in first iteration are the code
        variable try : unsigned(23 downto 0) := (others => '0');
        variable err_count : integer range 0 to 3 := 0;
        variable count_time: integer range 0 to 100e6 -1 := 0;
        variable reprog_step : integer range 0 to 2 := 0;
        variable reprogram_done : integer range 0 to 1 := 0;
    begin
        if rising_edge(CLK) then
            -- show current input numbers
            if s_reset = '1' then
                LED <= "0000";
                count <= 0;
                state <= s1;
                err_count := 0;
                -- reset display to show input numbers
            else
                case state is
                when s1 =>
                    LED <= "0001";
                    message(7 downto 0) <= I;
                    message(31 downto 8) <= (others => '0');
                    mode_dis <= "10";
                    if s_enter = '1' then
                        state <= s2;
                        try(7 downto 0) := unsigned(I);
                    end if;
                    if s_abort = '1' then 
                        state <= aborted;
                    end if;
                when s2 =>
                    LED <= "0010";
                    message(7 downto 0) <= I;
                    message(31 downto 8) <= (others => '0');
                    mode_dis <= "10";
                    if s_enter = '1' then
                        state <= s3;
                        try(15 downto 8) := unsigned(I);
                    end if;
                    if s_abort = '1' then 
                        state <= aborted;
                    end if;
                when s3 =>
                    LED <= "0100";
                    message(7 downto 0) <= I;
                    message(31 downto 8) <= (others => '0');
                    mode_dis <= "10";
                    if s_enter = '1' then
                        state <= check;
                        try(23 downto 16) := unsigned(I);
                    end if;
                    if s_abort = '1' then 
                        state <= aborted;
                    end if;
                when check =>
                    LED <= "0100";
                    if try = code then
                        state <= opened;
                    else                         
                        err_count := err_count + 1;
                        if err_count = 3 then
                            state <= locked;                            
                        else                             
                            state <= error;
                            end if;
                    end if;
                when opened =>
                    LED <= "0111";
                    mode_dis <= "11";
                    message <= x"4F" & x"50" & x"45" & x"4E";
                    err_count := 0;  
                    if s_abort = '1' then
                        state <= aborted;
                    elsif s_reprogram = '1' then
                        state <= reprogramming;
                    end if;                  
                when locked =>
                    LED <= "0000";
                    mode_dis <= "11";
                    message <= x"4C" & x"43" & x"4B" & x"44";
                when aborted =>
                    LED <= "0000";
                    mode_dis <= "11";
                    message <= x"41_42_52_54";
                    count_time := count_time + 1;
                    if count_time = 100e6 -1 then 
                        count_time := 0;
                        state <= s1;
                    end if; 
                when error =>
                    count_time := count_time + 1;
                    if err_count = 1 then
                        mode_dis <= "11";
                        message <= x"45" & x"52" & x"52" & x"31"; -- out "err1"
                    elsif err_count = 2 then
                        mode_dis <= "11";
                        message <= x"45" & x"52" & x"52" & x"32"; -- out "err2"
                    else
                        mode_dis <= "11";
                        message <= x"45" & x"52" & x"52" & x"46"; -- out "errF" debug
                    end if;
                    if count_time = 100e6 -1 then 
                        count_time := 0;
                        state <= s1;
                    end if;
                when reprogramming =>
                    if s_abort = '1' then
                        state <= opened;
                        reprog_step := 0;
                    end if;
                    message(7 downto 0) <= I;
                    message(31 downto 8) <= (others => '0');
                    mode_dis <= "10";
                    if reprog_step = 0 then
                        LED <= "1001";
                        if s_enter = '1' then
                            try(7 downto 0) := unsigned(I);
                            reprog_step := reprog_step + 1;
                        end if;
                    elsif reprog_step = 1 then 
                        LED <= "1010";
                        if s_enter = '1' then
                            try(15 downto 8) := unsigned(I);
                            reprog_step := reprog_step + 1;
                        end if;
                    else  
                        LED <= "1100";
                        if s_enter = '1' then
                            try(23 downto 16) := unsigned(I);                            
                            code := try; -- save new code   
                            reprogram_done := 1;                                                                       
                        end if;
                        if reprogram_done = 1 then
                            mode_dis <= "11";
                            message <= x"44_4F_4E_45"; -- "done"
                            count_time := count_time + 1;
                            if count_time = 100e6 -1 then 
                                reprog_step := 0;
                                reprogram_done := 0;
                                count_time := 0;
                                state <= s1;
                            end if;  
                        end if;
                    end if;
                end case;    
            end if;  
        end if;    
    end process;
end Behavioral;
