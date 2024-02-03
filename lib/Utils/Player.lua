local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

--> Class:
local PlayerUtil = {}

--> Types:
type HumanoidRootPart = Part & {
	OriginalSize: Vector3Value,
	RootAttachement: Attachment & {
		OriginalPosition: Vector3Value,
	},
	RootRigAttachment: Attachment & {
		OriginalPosition: Vector3Value,
	},
}

type Rig6CharacterType = Model & {
	["Body Colors"]: BodyColors,
	["Humanoid"]: Humanoid & { Animator: Animator },

	["Head"]: BasePart & {
		FaceCenterAttachment: Attachment,
		FaceFrontAttachment: Attachment,
		HairAttachment: Attachment,
		HatAttachment: Attachment,
		Mesh: SpecialMesh,
		face: Decal,
	},
	["HumanoidRootPart"]: BasePart & { RootJoint: Motor6D },
	["Left Arm"]: BasePart & {
		LeftGripAttachment: Attachment,
		LeftShoulderAttachment: Attachment,
	},
	["Left Leg"]: BasePart & {
		LeftFootAttachment: Attachment,
	},
	["Right Arm"]: BasePart & {
		RightGripAttachment: Attachment,
		RightShoulderAttachment: Attachment,
	},
	["Right Leg"]: BasePart & {
		RightFootAttachment: Attachment,
	},
	["Torso"]: BasePart & {
		BodyBackAttachment: Attachment,
		BodyFrontAttachment: Attachment,
		LeftCollarAttachment: Attachment,
		RightCollarAttachment: Attachment,
		NeckAttachment: Attachment,
		WaistBackAttachment: Attachment,
		WaistCenterAttachment: Attachment,
		WaistFrontAttachment: Attachment,
		roblox: Decal,

		["Left Hip"]: Motor6D,
		["Left Shoulder"]: Motor6D,
		["Neck"]: Motor6D,
		["Right Hip"]: Motor6D,
		["Right Shoulder"]: Motor6D,
	},
}

type CharacterType = {
	["Body Colors"]: BodyColors,
	HumanoidRootPart: HumanoidRootPart,
	Humanoid: Humanoid & {
		HumanoidDescription: HumanoidDescription,
		Animator: Animator,
	},
	["Head"]: Part & {
		face: Decal,
		Mesh: SpecialMesh,
	},
	["LeftFoot"]: Part,
	["LeftHand"]: Part,
	["RightFoot"]: Part,
	["RightHand"]: Part,
	["LeftLowerArm"]: Part,
	["LeftLowerLeg"]: Part,
	["LeftUpperArm"]: Part,
	["LeftUpperLeg"]: Part,
	["RightLowerArm"]: Part,
	["RightLowerLeg"]: Part,
	["RightUpperArm"]: Part,
	["RightUpperLeg"]: Part,
	["LowerTorso"]: Part,
	["UpperTorso"]: Part,
	["PrimaryPart"]: HumanoidRootPart,
} & Model

--> Functions:
function PlayerUtil.GetPlayer(UserId: number)
	if UserId then
		return Players:GetPlayerByUserId(UserId)
	elseif RunService:IsClient() and not UserId then
		return Players.LocalPlayer
	end
end
function PlayerUtil.GetCharacter(UserId: number): CharacterType
	local Player = PlayerUtil.GetPlayer(UserId)

	return Player and Player.Character or Player.CharacterAdded:Wait()
end

function PlayerUtil.GetCharacterR6(UserId: number): CharacterType
	local Player = PlayerUtil.GetPlayer(UserId)

	return Player and (Player.Character or Player.CharacterAdded:Wait())
end

function PlayerUtil.GetHead(UserId: number)
	return PlayerUtil.GetCharacter(UserId).Head
end

function PlayerUtil.GetHeadPosition(UserId: number)
	return PlayerUtil.GetHead(UserId).CFrame.Position
end

function PlayerUtil.GetHumanoidRootPart(UserId: number): HumanoidRootPart
	return PlayerUtil.GetCharacter(UserId).HumanoidRootPart
end

function PlayerUtil.GetHumanoid(UserId: number)
	local Character = PlayerUtil.GetCharacter(UserId)
	return Character.Humanoid
end

function PlayerUtil.GetHumanoidDescription(UserId: number)
	local Humanoid = PlayerUtil.GetHumanoid(UserId)
	return Humanoid:GetAppliedDescription()
end

function PlayerUtil.GetAnimator(UserId: number)
	local Humanoid = PlayerUtil.GetHumanoid(UserId)
	local Animator = Humanoid and (Humanoid.Animator or Humanoid:FindFirstChildOfClass("Animator"))
	return Animator
end

function PlayerUtil.LoadTrack(UserId: number, AnimationId: number)
	local Humanoid = PlayerUtil.GetHumanoid(UserId)
	local Animator = PlayerUtil.GetAnimator(UserId)

	if not Animator then
		return
	end

	local Animation = Instance.new("Animation")

	Animation.Name = "Girra - " .. AnimationId
	Animation.AnimationId = "rbxassetid://" .. AnimationId
	Animation.Parent = Humanoid.Parent

	return Animator:LoadAnimation(Animation)
end

return PlayerUtil
