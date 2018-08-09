# get the name of the branch we are on
function p4_prompt_info() {
    tmp_perforce_info=$(p4 where 2> /dev/null) || return
    perforce_branch=$(echo $tmp_perforce_info | head -n 1 | awk '{print $1}') || return
    echo "$ZSH_THEME_GIT_PROMPT_PREFIX$perforce_branch$ZSH_THEME_GIT_PROMPT_SUFFIX"
}
