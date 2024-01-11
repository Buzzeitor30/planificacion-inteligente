import numpy as np
import pddlgym
import random
import tqdm
'''
FUNCIONES AUXILIARES
'''

def get_q_update_score(current_q, reward, next_state):
    return current_q + learning_rate * (reward + gamma * np.max(next_state) - current_q)


def inc_byLinear(k=1):
    global epsilon
    epsilon = epsilon-k

def inc_byGeometric(t, k=.1):
    global epsilon
    epsilon = epsilon * k

def inc_byDivision(k=.1):
    global epsilon
    epsilon = epsilon / (1+epsilon * k)

'''
INICIALIZACI´ON DE PAR´AMETROS
'''
# Creo entorno pddlgym con el dominio
env = pddlgym.make("PDDLEnvBloques-v0")
# Fijo el problema al primero alfab´eticamente (por si hay varios)
env.fix_problem_index(0)
# Iniciar el entorno con el agente para que est´e en el lugar inicial
state, debug_info = env.reset()
# Definici´on de la Q-table
####################################################################
env.action_space.all_ground_literals(state)
n_actions =  len(env.action_space._all_ground_literals)
q_table = [[0] * n_actions]
states_to_rows = {state : 0}
columns_to_actions = dict(enumerate(env.action_space._all_ground_literals)) # la llamada al env devuelve una lista de accionnes (??? XD), asi que se puede hacer asi
actions_to_columns = {col:action for action, col in columns_to_actions.items()} #la inversa
####################################################################
'''
DEFINICI´ON DE HIPERPAR´AMETROS DEL Q-LEARNING
'''
total_episodes = 1000
learning_rate = 0.2 # Alpha in Q-learning algorithm
max_steps = 2000
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
# Entrenamos hasta un n´umero m´aximo de episodios (reinicios)
for episode in tqdm.tqdm(range(total_episodes)):
    state, debug = env.reset()
# El agente ir´a tomando decisiones hasta un n´umero m´aximo de pasos
    for step in range(max_steps):
        if random.uniform(0,1) > epsilon:
        # EXPLOTACION
            pass
        else:
        # EXPLORACI´ON SEG´UN ALGORITMO
            action = env.action_space.sample(state)
        new_state, reward, done, info = env.step(action)
        inc_byLinear(1/max_steps) #he puesto esto así
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
            q_table.append([0] * n_actions)
        
        q_table[last_row][col] = get_q_update_score(q_table[last_row][col], reward, q_table[row])

        state = new_state
        if done:
            break

'''
APLICACI´ON DE LA Q-TABLE PARA SACAR UN PLAN CON LA POL´ITICA
'''
state, debug = env.reset()
acciones =  []
estados = [state]
while True:
    # Valor num´erico del estado para sacar la fila de la tabla
    #index = vistos.index(state)
    index = states_to_rows[state]
    ####################################################################
    # #
    # RELLENAR: PLANIFICAR #
    # #
    ####################################################################
    best_action_idx = np.argmax(q_table[index])


    #accion_a_aplicar = None
    accion_a_aplicar = columns_to_actions[best_action_idx]
    acciones.append(accion_a_aplicar)
    state, reward, done, info = env.step(accion_a_aplicar)
    estados.append(state)
    # Acabo cuando llego al objetivo
    if done:
        break

print("Acciones para resolver el problema: ")
print(acciones)
print('#' * 20)
print('Estados x los que pasa')
print(estados)