﻿namespace XSharp.Assembler.x86
{
    public interface IInstructionWithCondition {
        ConditionalTestEnum Condition {
            get;
            set;
        }
    }
}
