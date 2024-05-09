export HF_TOKEN=YOUR_HF_TOKEN
export 'PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:32'
deepspeed --num_gpus 1 src/train_bash.py \
    --deepspeed examples/deepspeed/ds_z2_offload_config.json \
    --stage sft \
    --do_train \
    --model_name_or_path unsloth/llama-3-8b-Instruct-bnb-4bit \
    --dataset identity,alpaca_gpt4_en \
    --template llama3 \
    --finetuning_type lora \
    --lora_target all \
    --quantization_bit 4 \
    --output_dir ../llama-result-lora \
    --per_device_train_batch_size 1 \
    --per_device_eval_batch_size 1 \
    --gradient_accumulation_steps 4 \
    --lr_scheduler_type cosine \
    --log_level info \
    --logging_steps 5 \
    --save_strategy epoch \
    --save_total_limit 1 \
    --save_steps 100 \
    --learning_rate 5e-5 \
    --loraplus_lr_ratio 16 \
    --max_grad_norm 1 \
    --num_train_epochs 1.0 \
    --plot_loss \
    --do_eval false \
    --max_steps -1 \
    --bf16 true \
    --seed 42 \
    --warmup_ratio 0.1 \
    --cutoff_len 8192 \
    --flash_attn auto \
    --orpo_beta 0.05 \
    --overwrite_output_dir 