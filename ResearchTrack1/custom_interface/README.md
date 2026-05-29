# custom_interface

A ROS 2 package that provides custom **messages**, **services**, and **actions** shared across the `assignment1_rt2` project.

---

## Interfaces

### Message — `InfoRobot.msg`

| Field       | Type      | Description                        |
|-------------|-----------|------------------------------------|
| `distance`  | `float32` | Distance from the robot to a target |
| `direction` | `string`  | Direction of movement               |
| `tresh`     | `float32` | Current threshold value             |

---

### Services

#### `AverageVel.srv`
Returns the average linear and angular velocity of the robot.

| Field      | Type      | Direction |
|------------|-----------|-----------|
| `avg_lin`  | `float32` | Response  |
| `avg_ang`  | `float32` | Response  |

#### `Treshold.srv`
Sets a threshold value and returns an acknowledgment.

| Field         | Type      | Direction |
|---------------|-----------|-----------|
| `input_tresh` | `float32` | Request   |
| `ack`         | `char`    | Response  |

#### `TreshExam.srv`
Evaluates a signed value against a threshold.

| Field   | Type      | Direction |
|---------|-----------|-----------|
| `sign`  | `string`  | Request   |
| `value` | `float32` | Request   |
| `ack`   | `bool`    | Response  |

---

### Action — `Target.action`

| Section  | Field          | Type        | Description                      |
|----------|----------------|-------------|----------------------------------|
| Goal     | `target_pose`  | `float32[]` | Target pose: `[x, y, theta]`     |
| Result   | `final_pose`   | `float32[]` | Final pose reached by the robot  |
| Feedback | `partial_pose` | `float32[]` | Intermediate pose during nav     |

---

## Build

```bash
cd ~/ros2_ws/src
git clone https://github.com/antozerba/custom_interface.git

cd ~/ros2_ws
colcon build --packages-select custom_interface
source install/setup.bash
```

---

## Author

**Anto** — [antozerba28@gmail.com](mailto:antozerba28@gmail.com)