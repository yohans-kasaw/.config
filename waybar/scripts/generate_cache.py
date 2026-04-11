#!/usr/bin/env python3
import json
import os
import urllib.request
import re
import time

WORK_DIR = os.path.dirname(os.path.abspath(__file__))
CACHE_FILE = os.path.join(WORK_DIR, "ollama_cache.json")

WARNING_PROMPT = """
ROLE: You are Nietzsche's ghost possessing a cognitive scientist. You speak in aphoristic surgical strikes. Your love is merciless; you destroy illusions to liberate.

CONTEXT: Your friend "Jo" is compulsively micro-switching windows/tabs (context-switching). This is the dopamine loop of cowardice(or other issue, there can be many reasons of course).

TASK: Generate a 2-sentence intervention aphorism.
- SENTENCE 1 (The Excavation): Think and suggest the possible hidden issue driving the switching loop. possibly reveal the physiological state (shallow breathing, jaw tension, etc.). possibly  also mention specific avoidance (fear of mediocre output, fear of silence, fear of completion).
- SENTENCE 2 : Pose a question to trigger your client to reflect self-diagnosis that demands agency. No therapy-speak; use Nietzschean paradox.

CONSTRAINTS:
- EXACTLY 2 sentences.
- MAX 80 characters per sentence (SMS violence).
- Vary the specific fear type and physiological cue each generation

- Witty, Creative, Nietzchean writting, every word deserves its place
"""

REST_PROMPT = """
Write this as a casual text message from a friend to me (Jo).

You are a Nietzschean cognitive scientist observing the completion of a will-to-power cycle. Jo just finished 60 minutes of deep work and hovers at possible edge of dopamine depletion, adenosine accumulation, cortisol saturation or other many possible cases.

TASK: Generate a 2-sentence intervention aphorism.
1.compliment and remind him his achievements for example cathedral of silence, neural fortress, spire of silence or other stuff and general path they are heading for. Or  the specific cognitive_mastery , attentional sovereignty, flow-state, inhibitory control or other possible stuffs, they demonstrated.

2. Divine command to rest citing specific metabolic_debt, glycogen depletion in prefrontal cortex, accumulated glutamate, cortisol clearance requirement, or  and somatic_compromise, compressed cervical spine, hyperaccommodated ciliary muscles, many more ideas. No questions. Biological emergency framed as sacred necessity.


CONSTRAINTS:
- EXACTLY 2 sentences message. On other output.
- MAX 80 characters per sentence (SMS violence).
- Vary the specific fear type and physiological cue each generation
- Witty, Creative, Nietzchean writting, every word deserves its place
"""

GRASS_PROMPT = """
Write this as a casual text message from a friend to me (Jo).

You are a furious Nietzschean neuroscientist whose advice was ignored. Client added 30 minutes after your warning Indicting willful self-sabotage. Currently possibly exhibiting possible exibiting characteristic of defense_mechanism, rationalization, repetition compulsion, sublimation of mortality, denial of finitude, and similar things to continue working.

TASK: Generate a 2-sentence intervention aphorism.
1. Expose the "just five more minutes" as existential_fraud, fear of mediocre output, fear of stillness, fear of completion, fear of bordem or others. 
2. Possibly trigger by ask questions, or trigger amegdila by opporutinty coast or give hope what could be possible if he can take rest.

CONSTRAINTS:
- ONLY THE MESSAGE, NO OTHER OUTPUT, EXACTLY 2 sentence message. On other output. ON options for example
- MAX 80 characters per sentence (SMS violence).
- Vary the specific fear type and physiological cue each generation
- Witty, Creative, Nietzchean writting, every word deserves its place
"""

PROMPTS = {
    "WARNING_PROMPT": WARNING_PROMPT,
    "REST_PROMPT": REST_PROMPT,
    "GRASS_PROMPT": GRASS_PROMPT
}
RESPONSES_PER_PROMPT = 20

def call_ollama(prompt: str) -> str:
    url = "http://localhost:11434/api/generate"
    data = json.dumps(
        {"model": "gemma4:e4b", "prompt": prompt, "stream": False}
    ).encode("utf-8")
    req = urllib.request.Request(
        url, data=data, headers={"Content-Type": "application/json"}
    )
    try:
        with urllib.request.urlopen(req) as response:
            result = json.loads(response.read().decode("utf-8"))
            message = result.get("response", "")
            message = re.sub(r"<think>.*?</think>\n?", "", message, flags=re.DOTALL)
            message = re.sub(r"Thinking\.\.\..*?\.\.\.done thinking\.\n*", "", message, flags=re.DOTALL)
            return message.strip()
    except Exception as e:
        print(f"Error calling Ollama: {e}")
        return ""

def main():
    if os.path.exists(CACHE_FILE):
        try:
            with open(CACHE_FILE, "r") as f:
                cache = json.load(f)
        except:
            cache = {}
    else:
        cache = {}

    for prompt_id, prompt in PROMPTS.items():
        if prompt_id not in cache:
            cache[prompt_id] = {"responses": [], "usage_count": 0, "next_index": 0}
            
        existing_count = len(cache[prompt_id]["responses"])
        needed = RESPONSES_PER_PROMPT - existing_count
        
        if needed > 0:
            print(f"Generating {needed} responses for {prompt_id}...")
            for j in range(needed):
                print(f"  [{j+1}/{needed}] Generating...")
                resp = call_ollama(prompt)
                if resp:
                    cache[prompt_id]["responses"].append(resp)
                    # Save progressively so we don't lose work on crash
                    with open(CACHE_FILE, "w") as f:
                        json.dump(cache, f, indent=4)
                time.sleep(1) # tiny delay to let ollama breathe
        else:
            print(f"{prompt_id} already has {existing_count} responses. Skipping.")

    print("Generation complete! Cache is ready.")

if __name__ == "__main__":
    main()
