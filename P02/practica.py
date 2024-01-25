import numpy as np
import pddlgym
import random
import tqdm
import pandas as pd
import time
import argparse
'''
FUNCIONES AUXILIARES
'''
problem_id = 0
learning_rate = 0
gamma = 0
max_steps = 0
max_episodes = 0
debug_mode = False

def get_q_update_score(current_q, learning_rate, gamma, reward, next_state):
    return current_q + learning_rate * (reward + gamma * np.max(next_state) - current_q)


class DecrementFunc:
    def __init__(self, name, func) -> None:
        self.name = name
        self.func = func
    
    def __call__(self, k):
        return self.func(k)

    def get_name(self):
        return self.name

def inc_byLinear(k=1):
    global epsilon
    epsilon = epsilon-k

def inc_byGeometric(k=.1):
    global epsilon
    epsilon = epsilon * k

def inc_byDivision(k=.1):
    global epsilon
    epsilon = epsilon / (1+epsilon * k)


def q_table(problem_idx):
    '''
    INICIALIZACI´ON DE PAR´AMETROS
    '''
    # Creo entorno pddlgym con el dominio
    env = pddlgym.make("PDDLEnvPuerto-v0")
    # Fijo el problema al primero alfab´eticamente (por si hay varios)
    env.fix_problem_index(problem_idx)
    # Iniciar el entorno con el agente para que est´e en el lugar inicial
    state, debug_info = env.reset()
    # Definici´on de la Q-table
    ####################################################################
    env.action_space.all_ground_literals(state)
    n_total_actions =  len(env.action_space._all_ground_literals)
    q_table = [np.zeros(n_total_actions)]
    states_to_rows = {state : 0}
    columns_to_actions = dict(enumerate(env.action_space._all_ground_literals)) # la llamada al env devuelve una lista de accionnes (??? XD), asi que se puede hacer asi
    actions_to_columns = {col:action for action, col in columns_to_actions.items()} #la inversa
    ####################################################################
    '''
    DEFINICI´ON DE HIPERPAR´AMETROS DEL Q-LEARNING
    '''
    learning_rate = 0.2 # Alpha in Q-learning algorithm
    #max_steps = 500
    gamma = 0.99 # Discount factor
    ####################################################################
    # #
    # RELLENAR: PAR´AMETROS DE EXPLORACI´ON #
    # #
    ####################################################################
    # Ejemplo
    global epsilon
    epsilon = 1
    '''
    ALGORITMO Q-LEARNING
    '''
    start_time = time.perf_counter()
    # Entrenamos hasta un n´umero m´aximo de episodios (reinicios)
    for episode in tqdm.tqdm(range(max_episodes)):
        state, debug = env.reset()
    # El agente ir´a tomando decisiones hasta un n´umero m´aximo de pasos
        for step in range(max_steps):
            last_row = states_to_rows.get(state, -1)
            if random.uniform(0,1) > epsilon:
                max_value_action = np.max(q_table[last_row]) #sacamos el valor máximo
                all_max_actions_id = np.flatnonzero(q_table[last_row] == max_value_action) #nos quedamos con todos los índices que tienen el valor máximo
                action_id = np.random.choice(all_max_actions_id) #sampleamos una de forma aleatoria
                action = columns_to_actions[action_id] #nos quedamos con la acción máxima

            # EXPLOTACION
            else:
            # EXPLORACI´ON SEG´UN ALGORITMO
                action = env.action_space.sample(state)
            new_state, reward, done, info = env.step(action)
            #he puesto esto así
            ####################################################################
            # #
            # RELLENAR: ACTUALIZAR TABLA #
            # #
            ####################################################################
            #VIEJO ESTADO
            col = actions_to_columns[action]
            last_row = states_to_rows.get(state, -1)
            ##NUEVO ESTADO
            row = states_to_rows.get(new_state, -1)
            if row == -1:
                row = len(states_to_rows)
                states_to_rows[new_state] = len(states_to_rows)
                q_table.append(np.zeros(n_total_actions))
            
            q_table[last_row][col] = get_q_update_score(q_table[last_row][col], learning_rate, gamma, reward, q_table[row])

            state = new_state
            if done: 
                break
            decrement_fnc(1/(max_steps))
    end_time = time.perf_counter()

    total_time = end_time - start_time
    '''
    APLICACI´ON DE LA Q-TABLE PARA SACAR UN PLAN CON LA POL´ITICA
    '''
    state, debug = env.reset()
    acciones =  []
    estados = [state]
    max_n = 1e+7
    for _ in range(int(1e+7)):
        # Valor num´erico del estado para sacar la fila de la tabla
        #index = vistos.index(state)
        index = states_to_rows[state]
        ####################################################################
        # #
        # RELLENAR: PLANIFICAR #
        # #
        ####################################################################
        best_action_idx = np.argmax(q_table[index])
        accion_a_aplicar = columns_to_actions[best_action_idx]
        acciones.append(accion_a_aplicar)
        state, reward, done, info = env.step(accion_a_aplicar)
        estados.append(state)
        # Acabo cuando llego al objetivo
        if done:
            break
        max_n -= 1

    if debug_mode:
        print("Nº total de acciones en el espacio del problema:", n_total_actions)
        print("Nº de acciones necesario para resolver el problema:", len(acciones))
        print("Tiempo total para la convergencia del entrenamiento de la Q-tabla (s)", total_time)            
        print("Acciones para resolver el problema: ")
        print(acciones)
        print('#' * 20)
        print('Estados por los que pasa')
        print(estados)


	
if __name__ == "__main__":
    parser = argparse.ArgumentParser(
                    prog='Q-table for a pddl program',
                    description='Script for solving a PDDL problem through Q-table and PDDLGym')
    
    parser.add_argument("id", help="Problem ID", type=int)
    parser.add_argument("--max_steps", help="Max steps for Q-learning", type=int, default=2000)
    parser.add_argument("--max_episodes", help="Total episodes for Q-learning", type=int, default=2000)
    parser.add_argument("--decrement", help="Decrement function to be used. Default is linear", choices=["linear", "geometric", "division"], default="linear")
    parser.add_argument("--debug", help="Enable debug mode. Prints additional info such as the actions taken to solve the problem or the visited states in the process", action="store_true")
    parser.add_argument("--lr", help="Select learning rate", default=0.2, type=float)
    parser.add_argument("--gamma", help="Select gamma factor", default=0.99, type=float)
    args = parser.parse_args()

    problem_id = args.id
    max_steps = args.max_steps
    max_episodes = args.max_episodes
    decrement_fnc = DecrementFunc("LINEAR", inc_byLinear)
    learning_rate = args.lr
    gamma = args.gamma
    debug_mode = args.debug

    if args.decrement == "geometric":
        decrement_fnc = DecrementFunc("GEOMETRIC", inc_byGeometric)
    elif args.decrement == "division":
        decrement_fnc = DecrementFunc("DIVISION", inc_byDivision)
    
    q_table(problem_id)
