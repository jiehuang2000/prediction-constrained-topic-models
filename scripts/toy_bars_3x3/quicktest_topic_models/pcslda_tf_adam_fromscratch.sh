export XHOST_NTASKS=1
export XHOST_BASH_EXE=$PC_REPO_DIR/scripts/train_slda.sh
nickname=quicktest

export lossandgrad_mod_name="slda_loss__tensorflow"

# =============================== DATA SETTINGS
export dataset_name=toy_bars_3x3
export dataset_path="$PC_REPO_DIR/datasets/$dataset_name/"
export n_vocabs=9
export n_outputs=2
export n_train_docs=500

export n_batches=1

# =============================== OUTPUT SETTINGS
export param_output_fmt="topic_model_snapshot"
export n_steps_between_save=10
export n_steps_between_print=10
export n_seconds_between_save=-1
export n_seconds_between_print=-1
export n_steps_to_print_early=2
export n_steps_to_save_early=2
export laps_to_save_custom='0,1,2,4,6,8,10'

# =============================== ALGO SETTINGS
export n_laps=3

## Overall training: ADAM 
export alg_name="grad_descent_minimizer"
export step_direction='adam'
export decay_staircase=0
export decay_interval=1
export decay_rate=0.997
for step_size in 0.0333 #0.1000 0.3333
do
    export step_size=$step_size


## Per-doc inference settings
export pi_max_iters=5
export pi_step_size=0.05
export pi_max_iters_first_train_lap=3

# =============================== INIT SETTINGS
export init_model_path=none
for init_name in rand_smooth
do
    export init_name=$init_name

# =============================== MODEL HYPERS
export alpha=1.100
export tau=1.100
export lambda_w=0.001

export weight_x=1.0

## Loop over weights to place on log p(y|x)
for weight_y in 10.0 02.0 01.0
do
    export weight_y=$weight_y

for n_states in 004
do
    export n_states=$n_states

    export output_path="$XHOST_RESULTS_DIR/$dataset_name/$nickname-n_batches=$n_batches-lossandgrad_mod=$lossandgrad_mod_name-n_states=$n_states-alpha=$alpha-tau=$tau-lambda_w=$lambda_w-init_name=$init_name-alg_name=$alg_name-weight_x=$weight_x-weight_y=$weight_y-step_size=$step_size/1/"

    bash $SSCAPEROOT/scripts/launch_job_on_host_via_env.sh || { exit 1; }

done
done
done
done
