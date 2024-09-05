#!/usr/bin/env python3
import rclpy
from rclpy.node import Node
from geometry_msgs.msg import Twist
import rospy
from nav_msgs.msg import Twist as Twist1

class TwistBridge(Node):
    def __init__(self):
        super().__init__('twist_bridge')
        self.ros2_publisher = self.create_publisher(Twist, '/RosAria/cmd_vel', 10)
        self.ros1_subscriber = rospy.Subscriber('/RosAria/cmd_vel', Twist1, self.callback)

    def callback(self, ros1_msg):
        ros2_msg = Twist()
        ros2_msg.linear.x = ros1_msg.linear.x
        ros2_msg.linear.y = ros1_msg.linear.y
        ros2_msg.linear.z = ros1_msg.linear.z
        ros2_msg.angular.x = ros1_msg.angular.x
        ros2_msg.angular.y = ros1_msg.angular.y
        ros2_msg.angular.z = ros1_msg.angular.z
        self.ros2_publisher.publish(ros2_msg)

def main(args=None):
    rclpy.init(args=args)
    rospy.init_node('twist_bridge', anonymous=True)
    bridge = TwistBridge()
    rclpy.spin(bridge)
    bridge.destroy_node()
    rclpy.shutdown()

if __name__ == '__main__':
    main()